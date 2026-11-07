import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Serves RainViewer radar tiles to a Google Maps [TileOverlay].
///
/// RainViewer only renders radar up to zoom 7. For deeper zoom levels the
/// provider requests the matching parent tile and crops the region that belongs
/// to the requested tile, instead of asking for the "Zoom Level Not Supported"
/// placeholder image.
class RainViewerTileProvider extends TileProvider {
  RainViewerTileProvider({
    required this.tileUrlTemplate,
    this.maxNativeZoom = 7,
    Dio? dio,
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               connectTimeout: const Duration(seconds: 8),
               receiveTimeout: const Duration(seconds: 12),
             ),
           );

  static const int _tileSize = 256;
  static const int _maxCacheEntries = 240;

  final String tileUrlTemplate;
  final int maxNativeZoom;
  final Dio _dio;

  final Map<String, Uint8List> _rawTiles = {};
  final Map<String, Uint8List> _croppedTiles = {};

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    if (zoom == null || zoom < 0) {
      return TileProvider.noTile;
    }

    final requestKey = '$zoom/$x/$y';
    final cachedTile = _croppedTiles[requestKey];
    if (cachedTile != null) {
      return Tile(_tileSize, _tileSize, cachedTile);
    }

    final nativeZoom = zoom > maxNativeZoom ? maxNativeZoom : zoom;
    final scale = 1 << (zoom - nativeZoom);
    final parentX = x ~/ scale;
    final parentY = y ~/ scale;

    Uint8List? source;
    try {
      source = await _fetchTile(nativeZoom, parentX, parentY);
    } catch (_) {
      return TileProvider.noTile;
    }
    if (source == null) {
      return TileProvider.noTile;
    }

    Uint8List? result = source;
    if (scale > 1) {
      try {
        result = await _cropTile(
          source,
          subX: x % scale,
          subY: y % scale,
          scale: scale,
        );
      } catch (_) {
        return TileProvider.noTile;
      }
    }
    if (result == null) {
      return TileProvider.noTile;
    }

    _remember(_croppedTiles, requestKey, result);
    return Tile(_tileSize, _tileSize, result);
  }

  Future<Uint8List?> _fetchTile(int zoom, int x, int y) async {
    final key = '$zoom/$x/$y';
    final cached = _rawTiles[key];
    if (cached != null) {
      return cached;
    }

    final url = tileUrlTemplate
        .replaceAll('{z}', '$zoom')
        .replaceAll('{x}', '$x')
        .replaceAll('{y}', '$y');

    final response = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final data = response.data;
    if (data == null || data.isEmpty) {
      return null;
    }

    final bytes = Uint8List.fromList(data);
    _remember(_rawTiles, key, bytes);
    return bytes;
  }

  Future<Uint8List?> _cropTile(
    Uint8List bytes, {
    required int subX,
    required int subY,
    required int scale,
  }) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final sourceSize = _tileSize / scale;
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawImageRect(
      image,
      ui.Rect.fromLTWH(
        subX * sourceSize,
        subY * sourceSize,
        sourceSize,
        sourceSize,
      ),
      ui.Rect.fromLTWH(0, 0, _tileSize.toDouble(), _tileSize.toDouble()),
      ui.Paint()..filterQuality = ui.FilterQuality.medium,
    );

    final picture = recorder.endRecording();
    final output = await picture.toImage(_tileSize, _tileSize);
    final data = await output.toByteData(format: ui.ImageByteFormat.png);

    output.dispose();
    picture.dispose();
    image.dispose();
    codec.dispose();

    return data?.buffer.asUint8List();
  }

  void _remember(Map<String, Uint8List> cache, String key, Uint8List value) {
    cache[key] = value;
    if (cache.length > _maxCacheEntries) {
      cache.remove(cache.keys.first);
    }
  }
}

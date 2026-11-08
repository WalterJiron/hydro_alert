import 'dart:async';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mbx;

import '../../domain/entities/radar_frame.dart';

/// Renders the RainViewer radar animation with native Mapbox raster layers.
///
/// One source/layer pair is created per frame and only the active frame is
/// visible. The frames are installed below the annotation layers so the
/// community report and earthquake pins always stay on top.
///
/// Every style mutation runs through a serialized queue because the Mapbox
/// style manager rejects overlapping structural changes.
class RadarOverlayController {
  static const String _sourcePrefix = 'hydroalert-radar-source-';
  static const String _layerPrefix = 'hydroalert-radar-layer-';

  static const double _opacity = 0.9;
  static const double _contrast = 0.22;
  static const double _saturation = 0.35;
  static const double _brightnessMin = 0.04;
  static const double _brightnessMax = 0.96;

  mbx.MapboxMap? _map;
  List<RadarFrame> _frames = const <RadarFrame>[];
  int _activeIndex = 0;
  bool _enabled = false;
  bool _styleReady = false;
  bool _installed = false;
  bool _needsReinstall = false;
  int _installedCount = 0;
  int _appliedActiveIndex = -1;
  String? _belowLayerId;
  Future<void> _queue = Future<void>.value();
  bool _disposed = false;

  void attach(mbx.MapboxMap map) {
    _map = map;
  }

  /// Radar layers must be re-added every time the style finishes loading,
  /// including style reloads.
  void setStyleReady(bool ready) {
    _styleReady = ready;
    _installed = false;
    _needsReinstall = false;
    _appliedActiveIndex = -1;
    if (ready) {
      _schedule();
    }
  }

  /// Reference layer used to keep the radar below every map pin.
  void setBelowLayerId(String? layerId) {
    _belowLayerId = layerId;
  }

  void sync({
    required bool enabled,
    required List<RadarFrame> frames,
    required int activeIndex,
  }) {
    if (_disposed) {
      return;
    }

    var changed = enabled != _enabled;
    _enabled = enabled;

    if (!_sameFrames(frames)) {
      _frames = List<RadarFrame>.of(frames);
      // Keep _installed as-is so the next apply can delete the old layers
      // before adding the new frame set.
      _needsReinstall = _installed;
      _appliedActiveIndex = -1;
      changed = true;
    }

    final safeIndex = _frames.isEmpty
        ? 0
        : activeIndex.clamp(0, _frames.length - 1).toInt();
    if (safeIndex != _activeIndex) {
      _activeIndex = safeIndex;
      changed = true;
    }

    if (changed) {
      _schedule();
    }
  }

  void _schedule() {
    if (_disposed || !_styleReady || _map == null) {
      return;
    }
    _queue = _queue.then((_) => _apply()).catchError((Object _) {
      // A style reload can invalidate a queued call; the next sync retries.
    });
  }

  Future<void> _apply() async {
    final map = _map;
    if (map == null || _disposed || !_styleReady) {
      return;
    }

    if (!_enabled) {
      await _hideAll(map);
      return;
    }

    if (_frames.isEmpty) {
      await _hideAll(map);
      return;
    }

    if (_installed && _needsReinstall) {
      await _removeInstalled(map);
      if (_disposed) {
        return;
      }
    }

    if (!_installed) {
      await _removeInstalled(map);
      if (_disposed) {
        return;
      }

      final belowLayer = await _resolveBelowLayer(map);
      for (var index = 0; index < _frames.length; index++) {
        final sourceId = '$_sourcePrefix$index';
        final layerId = '$_layerPrefix$index';
        final frame = _frames[index];

        await map.addSource(
          mbx.RasterSource(
            id: sourceId,
            tiles: <String?>[frame.tileUrlTemplate],
            tileSize: 256,
            minzoom: 0,
            maxzoom: 7,
            scheme: mbx.Scheme.XYZ,
          ),
        );
        await map.addLayer(
          mbx.RasterLayer(
            id: layerId,
            sourceId: sourceId,
            rasterOpacity: _opacity,
            rasterContrast: _contrast,
            rasterSaturation: _saturation,
            rasterBrightnessMin: _brightnessMin,
            rasterBrightnessMax: _brightnessMax,
            rasterResampling: mbx.RasterResampling.LINEAR,
            rasterFadeDuration: 220,
            visibility: index == _activeIndex
                ? mbx.Visibility.VISIBLE
                : mbx.Visibility.NONE,
          ),
        );

        if (belowLayer != null) {
          try {
            await map.moveStyleLayer(
              layerId,
              mbx.LayerPosition(below: belowLayer),
            );
          } catch (_) {
            // The reference layer may disappear during a style reload.
          }
        }
      }

      if (_disposed) {
        return;
      }
      _installed = true;
      _needsReinstall = false;
      _installedCount = _frames.length;
      _appliedActiveIndex = _activeIndex;
      return;
    }

    if (_appliedActiveIndex == _activeIndex) {
      return;
    }

    if (_appliedActiveIndex >= 0 && _appliedActiveIndex < _installedCount) {
      await _setVisibility(map, _appliedActiveIndex, false);
    }
    await _setVisibility(map, _activeIndex, true);
    _appliedActiveIndex = _activeIndex;
  }

  Future<void> _hideAll(mbx.MapboxMap map) async {
    if (!_installed) {
      _appliedActiveIndex = -1;
      return;
    }
    for (var index = 0; index < _installedCount; index++) {
      await _setVisibility(map, index, false);
    }
    _appliedActiveIndex = -1;
  }

  Future<void> _setVisibility(
    mbx.MapboxMap map,
    int index,
    bool visible,
  ) async {
    try {
      await map.setStyleLayerProperty(
        '$_layerPrefix$index',
        'visibility',
        visible ? 'visible' : 'none',
      );
    } catch (_) {
      // Ignore a layer that a style reload already removed.
    }
  }

  Future<void> _removeInstalled(mbx.MapboxMap map) async {
    if (!_installed) {
      return;
    }
    for (var index = 0; index < _installedCount; index++) {
      try {
        await map.removeStyleLayer('$_layerPrefix$index');
      } catch (_) {
        // Layer already gone.
      }
    }
    for (var index = 0; index < _installedCount; index++) {
      try {
        await map.removeStyleSource('$_sourcePrefix$index');
      } catch (_) {
        // Source already gone.
      }
    }
    _installed = false;
    _needsReinstall = false;
    _installedCount = 0;
    _appliedActiveIndex = -1;
  }

  Future<String?> _resolveBelowLayer(mbx.MapboxMap map) async {
    final candidate = _belowLayerId;
    if (candidate == null) {
      return null;
    }

    try {
      if (await map.styleLayerExists(candidate)) {
        return candidate;
      }
    } catch (_) {
      // Fall through to the prefix lookup.
    }

    try {
      final layers = await map.getStyleLayers();
      for (final layer in layers) {
        final id = layer?.id;
        if (id != null && id.startsWith(candidate)) {
          return id;
        }
      }
    } catch (_) {
      // The style is not ready yet.
    }
    return null;
  }

  bool _sameFrames(List<RadarFrame> frames) {
    if (frames.length != _frames.length) {
      return false;
    }
    for (var index = 0; index < frames.length; index++) {
      if (frames[index].tileUrlTemplate != _frames[index].tileUrlTemplate) {
        return false;
      }
    }
    return true;
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    final map = _map;
    if (map != null && _installed) {
      final queued = _queue;
      unawaited(queued.then((_) => _removeInstalled(map)));
    }
    _map = null;
  }
}

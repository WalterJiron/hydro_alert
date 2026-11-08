import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/radar_frame.dart';
import '../models/rainviewer_response.dart';

class RainViewerDataSource {
  const RainViewerDataSource(this._dio);

  final Dio _dio;

  /// Recent radar frames, oldest first.
  ///
  /// RainViewer publishes a ten-minute sequence in `past`; `nowcast` is only
  /// used when the past list is empty so the animation always has data.
  static const int _maxFrames = 12;

  Future<List<RadarFrame>> fetchRadarFrames() async {
    final response = await ApiClient.run(
      () => _dio.get<Map<String, dynamic>>(
        ApiEndpoints.rainViewerWeatherMapsPath,
      ),
    );

    final data = response.data;
    if (data == null) {
      return const <RadarFrame>[];
    }

    try {
      final model = RainViewerResponse.fromJson(data);
      final radar = model.radar;
      if (radar == null) {
        return const <RadarFrame>[];
      }

      final source = radar.past.isNotEmpty ? radar.past : radar.nowcast;
      final frames =
          source
              .where((frame) => frame.path != null && frame.time != null)
              .toList()
            ..sort((a, b) => (a.time ?? 0).compareTo(b.time ?? 0));

      if (frames.isEmpty) {
        return const <RadarFrame>[];
      }

      final recent = frames.length > _maxFrames
          ? frames.sublist(frames.length - _maxFrames)
          : frames;
      final host = (model.host ?? 'https://tilecache.rainviewer.com')
          .replaceAll(RegExp(r'/$'), '');

      return recent
          .map((frame) {
            final path = frame.path!.startsWith('/')
                ? frame.path!
                : '/${frame.path!}';
            return RadarFrame(
              observedAt: DateTime.fromMillisecondsSinceEpoch(
                frame.time! * 1000,
                isUtc: true,
              ).toLocal(),
              // RainViewer currently documents scheme 2 (Universal Blue) as the
              // only public palette. Intense cells still render in yellow/red, and
              // the overlay opacity is tuned so they remain visible over the
              // light map.
              tileUrlTemplate: '$host$path/256/{z}/{x}/{y}/2/1_1.png',
            );
          })
          .toList(growable: false);
    } catch (error) {
      throw ParsingFailure(cause: error);
    }
  }
}

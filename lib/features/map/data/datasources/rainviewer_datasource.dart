import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/radar_frame.dart';
import '../models/rainviewer_response.dart';

class RainViewerDataSource {
  const RainViewerDataSource(this._dio);

  final Dio _dio;

  Future<RadarFrame?> fetchLatestRadarFrame() async {
    final response = await ApiClient.run(
      () => _dio.get<Map<String, dynamic>>(
        ApiEndpoints.rainViewerWeatherMapsPath,
      ),
    );

    final data = response.data;
    if (data == null) {
      return null;
    }

    try {
      final model = RainViewerResponse.fromJson(data);
      final radar = model.radar;
      if (radar == null) {
        return null;
      }

      final frames = <RainViewerFrame>[
        ...radar.past,
        ...radar.nowcast,
      ].where((frame) => frame.path != null && frame.time != null).toList();

      if (frames.isEmpty) {
        return null;
      }

      frames.sort((a, b) => (a.time ?? 0).compareTo(b.time ?? 0));
      final latest = frames.last;
      final host = (model.host ?? 'https://tilecache.rainviewer.com')
          .replaceAll(RegExp(r'/$'), '');
      final path = latest.path!.startsWith('/')
          ? latest.path!
          : '/${latest.path!}';

      return RadarFrame(
        observedAt: DateTime.fromMillisecondsSinceEpoch(
          latest.time! * 1000,
          isUtc: true,
        ).toLocal(),
        // RainViewer currently documents scheme 2 (Universal Blue) as the only
        // public palette. Intense cells still render in yellow/red, and the
        // overlay opacity is tuned so they remain visible over the light map.
        tileUrlTemplate: '$host$path/256/{z}/{x}/{y}/2/1_1.png',
      );
    } catch (error) {
      throw ParsingFailure(cause: error);
    }
  }
}

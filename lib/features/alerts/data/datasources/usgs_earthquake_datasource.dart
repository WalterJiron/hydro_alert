import 'package:dio/dio.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/seismic_event.dart';
import '../models/earthquake_model.dart';

class UsgsEarthquakeDataSource {
  const UsgsEarthquakeDataSource(this._dio);

  final Dio _dio;

  Future<List<SeismicEvent>> fetchRecentEarthquakes() async {
    final now = DateTime.now().toUtc();
    final start = now.subtract(
      const Duration(days: AppConfig.usgsLookbackDays),
    );

    final response = await ApiClient.run(
      () => _dio.get<Map<String, dynamic>>(
        ApiEndpoints.usgsQueryPath,
        queryParameters: <String, dynamic>{
          'format': 'geojson',
          'minlatitude': ApiEndpoints.usgsMinLatitude,
          'maxlatitude': ApiEndpoints.usgsMaxLatitude,
          'minlongitude': ApiEndpoints.usgsMinLongitude,
          'maxlongitude': ApiEndpoints.usgsMaxLongitude,
          'orderby': 'time',
          'minmagnitude': AppConfig.usgsMinMagnitude,
          'starttime': start.toIso8601String().split('T').first,
          'limit': AppConfig.usgsLimit,
        },
      ),
    );

    final data = response.data;
    if (data == null) {
      return const <SeismicEvent>[];
    }

    try {
      final collection = UsgsFeatureCollection.fromJson(data);
      final events =
          collection.features.map(_toEntity).whereType<SeismicEvent>().toList()
            ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
      return events;
    } catch (error) {
      throw ParsingFailure(cause: error);
    }
  }

  SeismicEvent? _toEntity(UsgsFeature feature) {
    final magnitude = feature.properties.mag;
    final time = feature.properties.time;
    final coordinates = feature.geometry.coordinates;

    if (magnitude == null || time == null || coordinates.length < 2) {
      return null;
    }

    final longitude = coordinates[0];
    final latitude = coordinates[1];
    final depth = coordinates.length >= 3 ? coordinates[2] : null;

    return SeismicEvent(
      id: feature.id,
      magnitude: magnitude,
      place: feature.properties.place?.trim().isNotEmpty == true
          ? feature.properties.place!.trim()
          : 'Ubicación no disponible',
      occurredAt: DateTime.fromMillisecondsSinceEpoch(
        time,
        isUtc: true,
      ).toLocal(),
      latitude: latitude,
      longitude: longitude,
      depthKm: depth,
      url: feature.properties.url,
      reviewStatus: feature.properties.status,
      tsunami: (feature.properties.tsunami ?? 0) == 1,
    );
  }
}

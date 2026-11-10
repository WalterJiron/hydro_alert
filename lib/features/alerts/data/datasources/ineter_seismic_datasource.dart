import 'package:dio/dio.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/seismic_event.dart';
import '../models/ineter_seismic_event_model.dart';

/// Primary seismic source: INETER events synchronized by the HydroAlert
/// backend. The USGS datasource remains as a fallback.
class IneterSeismicDataSource {
  const IneterSeismicDataSource(this._dio);

  final Dio _dio;

  Future<List<SeismicEvent>> fetchRecentSeismicEvents() async {
    final from = DateTime.now().toUtc().subtract(
      const Duration(days: AppConfig.ineterLookbackDays),
    );

    final response = await ApiClient.run(
      () => _dio.get<Object?>(
        ApiEndpoints.seismicEventsPath,
        queryParameters: <String, dynamic>{
          'page': 1,
          'page_size': AppConfig.ineterPageSize,
          'from_date': from.toIso8601String().split('T').first,
        },
      ),
    );

    try {
      final items = _extractItems(response.data);
      final events = <SeismicEvent>[];
      for (final item in items) {
        if (item is! Map) {
          continue;
        }
        try {
          final model = IneterSeismicEventModel.fromJson(
            Map<String, dynamic>.from(item),
          );
          final event = model.toEntity();
          if (event != null) {
            events.add(event);
          }
        } on FormatException {
          // Ignore a single malformed event instead of hiding the whole list.
        }
      }

      events.sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
      return events;
    } catch (error) {
      throw ParsingFailure(cause: error);
    }
  }

  List<Object?> _extractItems(Object? data) {
    if (data is Map<String, dynamic>) {
      final items = data['items'];
      if (items is List<Object?>) {
        return items;
      }
    }
    if (data is Map) {
      final items = data['items'];
      if (items is List) {
        return items.cast<Object?>();
      }
    }
    throw const ParsingFailure(
      message: 'La respuesta sísmica tiene un formato inesperado.',
    );
  }
}

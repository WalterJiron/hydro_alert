import '../../../../app/constants/api_endpoints.dart';
import '../../domain/entities/seismic_event.dart';

/// One event returned by `GET /api/v1/seismic-events` (INETER sync).
class IneterSeismicEventModel {
  const IneterSeismicEventModel({
    required this.id,
    required this.eventAt,
    required this.latitude,
    required this.longitude,
    required this.location,
    this.magnitude,
    this.depthKm,
    this.status,
    this.country,
    this.source,
  });

  factory IneterSeismicEventModel.fromJson(Map<String, dynamic> json) {
    final id = _asString(json['id']);
    final eventAt = _parseDate(json['event_at']) ?? _parseLocalDate(json);
    final latitude = _asDouble(json['latitude']);
    final longitude = _asDouble(json['longitude']);

    if (id == null ||
        eventAt == null ||
        latitude == null ||
        longitude == null) {
      throw const FormatException('Evento sísmico de INETER inválido.');
    }

    return IneterSeismicEventModel(
      id: id,
      eventAt: eventAt,
      latitude: latitude,
      longitude: longitude,
      location: _asString(json['location']) ?? 'Ubicación no disponible',
      magnitude: _asDouble(json['magnitude']),
      depthKm: _asDouble(json['depth_km']),
      status: _asString(json['status']),
      country: _asString(json['pais']),
      source: _asString(json['source']),
    );
  }

  final String id;
  final DateTime eventAt;
  final double latitude;
  final double longitude;
  final String location;
  final double? magnitude;
  final double? depthKm;
  final String? status;
  final String? country;
  final String? source;

  SeismicEvent? toEntity() {
    final eventMagnitude = magnitude;
    if (eventMagnitude == null) {
      return null;
    }

    return SeismicEvent(
      id: id,
      magnitude: eventMagnitude,
      place: location,
      occurredAt: eventAt.toLocal(),
      latitude: latitude,
      longitude: longitude,
      depthKm: depthKm,
      url: ApiEndpoints.ineterSite,
      reviewStatus: status,
      source: _normalizedSource,
    );
  }

  String get _normalizedSource {
    final value = source?.trim();
    if (value == null || value.isEmpty) {
      return 'INETER';
    }
    return value.toUpperCase();
  }

  static DateTime? _parseDate(Object? value) {
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  static DateTime? _parseLocalDate(Map<String, dynamic> json) {
    final date = _asString(json['event_date']);
    final time = _asString(json['event_time']);
    if (date == null || time == null) {
      return null;
    }
    // INETER publishes Nicaraguan local time (UTC-6, no DST).
    return DateTime.tryParse('${date}T$time-06:00');
  }

  static String? _asString(Object? value) {
    return value is String && value.trim().isNotEmpty ? value.trim() : null;
  }

  static double? _asDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}

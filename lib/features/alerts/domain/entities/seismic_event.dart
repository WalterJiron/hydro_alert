import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismic_event.freezed.dart';

@freezed
abstract class SeismicEvent with _$SeismicEvent {
  const factory SeismicEvent({
    required String id,
    required double magnitude,
    required String place,
    required DateTime occurredAt,
    required double latitude,
    required double longitude,
    double? depthKm,
    String? url,
    String? reviewStatus,
    @Default(false) bool tsunami,
    @Default('USGS') String source,
  }) = _SeismicEvent;

  const SeismicEvent._();

  bool get isSignificant => magnitude >= 4.5;

  String get magnitudeLabel => magnitude.toStringAsFixed(1);

  String get depthLabel {
    final depth = depthKm;
    if (depth == null) {
      return 'Profundidad no disponible';
    }
    return '${depth.toStringAsFixed(1)} km de profundidad';
  }
}

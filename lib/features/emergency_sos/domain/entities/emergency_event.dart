import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_event.freezed.dart';

enum EmergencySource { seismic, push }

@freezed
abstract class EmergencyEvent with _$EmergencyEvent {
  const factory EmergencyEvent({
    required String id,
    required EmergencySource source,
    required String title,
    required String message,
    required DateTime receivedAt,
    DateTime? occurredAt,
    double? magnitude,
    String? place,
    double? latitude,
    double? longitude,
    double? depthKm,
    String? externalUrl,
  }) = _EmergencyEvent;

  const EmergencyEvent._();

  bool get isSeismic => source == EmergencySource.seismic;

  String get sourceLabel {
    return switch (source) {
      EmergencySource.seismic => 'Evento sísmico · INETER',
      EmergencySource.push => 'Notificación de emergencia',
    };
  }
}

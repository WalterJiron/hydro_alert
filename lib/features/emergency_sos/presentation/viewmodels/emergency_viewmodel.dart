import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/services/push_emergency_message.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../domain/entities/emergency_event.dart';

part 'emergency_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class EmergencyViewModel extends _$EmergencyViewModel {
  final Set<String> _dismissedIds = <String>{};

  @override
  EmergencyEvent? build() => null;

  void evaluateSeismicEvents(List<SeismicEvent> events) {
    if (state != null) {
      return;
    }

    final now = DateTime.now();
    final maxAge = Duration(minutes: AppConfig.sosEventMaxAgeMinutes);
    final threshold = AppConfig.sosMagnitudeThreshold;

    final candidates =
        events
            .where(
              (event) =>
                  event.magnitude >= threshold &&
                  event.occurredAt.isAfter(now.subtract(maxAge)) &&
                  !_dismissedIds.contains(event.id),
            )
            .toList()
          ..sort((a, b) {
            final magnitudeComparison = b.magnitude.compareTo(a.magnitude);
            if (magnitudeComparison != 0) {
              return magnitudeComparison;
            }
            return b.occurredAt.compareTo(a.occurredAt);
          });

    if (candidates.isEmpty) {
      return;
    }

    final event = candidates.first;
    state = EmergencyEvent(
      id: event.id,
      source: EmergencySource.seismic,
      title: 'Sismo detectado',
      message:
          'Se registró un sismo de magnitud ${event.magnitudeLabel} cerca de ${event.place}.',
      receivedAt: now,
      occurredAt: event.occurredAt,
      magnitude: event.magnitude,
      place: event.place,
      latitude: event.latitude,
      longitude: event.longitude,
      depthKm: event.depthKm,
      externalUrl: event.url,
    );
  }

  void triggerPush(PushEmergencyMessage message) {
    if (_dismissedIds.contains(message.id) || state != null) {
      return;
    }

    state = EmergencyEvent(
      id: message.id,
      source: EmergencySource.push,
      title: message.title,
      message: message.body,
      receivedAt: message.receivedAt,
      occurredAt: message.receivedAt,
      magnitude: message.magnitude,
      place: message.place,
      latitude: message.latitude,
      longitude: message.longitude,
      externalUrl: message.externalUrl,
    );
  }

  void dismiss() {
    final current = state;
    if (current != null) {
      _dismissedIds.add(current.id);
    }
    state = null;
  }

  void clear() {
    state = null;
  }
}

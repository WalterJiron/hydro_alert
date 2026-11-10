import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/services/seismic_notification_service.dart';
import '../../data/repositories/alerts_repository_impl.dart';
import '../../domain/entities/seismic_event.dart';

part 'alerts_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AlertsViewModel extends _$AlertsViewModel {
  Timer? _timer;
  bool _disposed = false;

  final Set<String> _notifiedIds = <String>{};

  @override
  Future<List<SeismicEvent>> build() async {
    _timer = Timer.periodic(const Duration(minutes: 5), (_) {
      unawaited(_refreshSilently());
    });
    ref.onDispose(() {
      _disposed = true;
      _timer?.cancel();
    });

    final events = await ref
        .watch(alertsRepositoryProvider)
        .fetchRecentEarthquakes();
    for (final e in events) {
      _notifiedIds.add(e.id);
    }
    return events;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(alertsRepositoryProvider).fetchRecentEarthquakes(),
    );
    _notifyNewStrongEvents(state.value ?? []);
  }

  Future<void> _refreshSilently() async {
    if (_disposed) return;

    try {
      final events = await ref
          .read(alertsRepositoryProvider)
          .fetchRecentEarthquakes();
      if (!_disposed) {
        state = AsyncData(events);
        _notifyNewStrongEvents(events);
      }
    } catch (_) {}
  }

  void _notifyNewStrongEvents(List<SeismicEvent> events) {
    if (_disposed) return;

    final threshold = AppConfig.sosMagnitudeThreshold;
    final notificationService = ref.read(seismicNotificationServiceProvider);

    for (final event in events) {
      if (event.magnitude >= threshold && !_notifiedIds.contains(event.id)) {
        _notifiedIds.add(event.id);
        unawaited(notificationService.showSeismicAlert(event));
      }
    }
  }
}

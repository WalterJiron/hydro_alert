import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/alerts_repository_impl.dart';
import '../../domain/entities/seismic_event.dart';

part 'alerts_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AlertsViewModel extends _$AlertsViewModel {
  Timer? _timer;
  bool _disposed = false;

  @override
  Future<List<SeismicEvent>> build() async {
    _timer = Timer.periodic(const Duration(minutes: 5), (_) {
      unawaited(_refreshSilently());
    });
    ref.onDispose(() {
      _disposed = true;
      _timer?.cancel();
    });

    return ref.watch(alertsRepositoryProvider).fetchRecentEarthquakes();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(alertsRepositoryProvider).fetchRecentEarthquakes(),
    );
  }

  Future<void> _refreshSilently() async {
    if (_disposed) {
      return;
    }

    try {
      final events = await ref
          .read(alertsRepositoryProvider)
          .fetchRecentEarthquakes();
      if (!_disposed) {
        state = AsyncData(events);
      }
    } catch (_) {
      // Keep the last successful data if a background refresh fails.
    }
  }
}

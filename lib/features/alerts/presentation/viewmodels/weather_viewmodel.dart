import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/alerts_repository_impl.dart';
import '../../domain/entities/weather_snapshot.dart';

part 'weather_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class WeatherViewModel extends _$WeatherViewModel {
  Timer? _timer;
  bool _disposed = false;

  @override
  Future<WeatherSnapshot> build() async {
    _timer = Timer.periodic(const Duration(minutes: 15), (_) {
      unawaited(_refreshSilently());
    });
    ref.onDispose(() {
      _disposed = true;
      _timer?.cancel();
    });

    return ref.watch(alertsRepositoryProvider).fetchCurrentWeather();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(alertsRepositoryProvider).fetchCurrentWeather(),
    );
  }

  Future<void> _refreshSilently() async {
    if (_disposed) {
      return;
    }

    try {
      final weather = await ref
          .read(alertsRepositoryProvider)
          .fetchCurrentWeather();
      if (!_disposed) {
        state = AsyncData(weather);
      }
    } catch (_) {
      // Keep the last successful weather snapshot.
    }
  }
}

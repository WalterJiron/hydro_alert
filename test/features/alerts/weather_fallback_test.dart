import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/core/errors/app_failure.dart';
import 'package:hydro_alert/features/alerts/data/datasources/usgs_earthquake_datasource.dart';
import 'package:hydro_alert/features/alerts/data/datasources/weather_data_source.dart';
import 'package:hydro_alert/features/alerts/data/repositories/alerts_repository_impl.dart';
import 'package:hydro_alert/features/alerts/domain/entities/weather_snapshot.dart';

WeatherSnapshot _snapshot(double temperatureC) {
  return WeatherSnapshot(
    temperatureC: temperatureC,
    feelsLikeC: temperatureC,
    humidity: 70,
    condition: 'Despejado',
    weatherMain: 'Clear',
    iconCode: '01d',
    observedAt: DateTime.utc(2026, 11, 7, 16),
    latitude: 12.136389,
    longitude: -86.251389,
  );
}

class _FakeWeatherDataSource implements WeatherDataSource {
  _FakeWeatherDataSource({this.result, this.error});

  final WeatherSnapshot? result;
  final Object? error;
  int calls = 0;

  @override
  Future<WeatherSnapshot> fetchCurrentWeather({
    double latitude = 0,
    double longitude = 0,
  }) async {
    calls++;
    if (error != null) {
      throw error!;
    }
    return result!;
  }
}

AlertsRepositoryImpl _repository({
  WeatherDataSource? primary,
  WeatherDataSource? fallback,
}) {
  return AlertsRepositoryImpl(
    earthquakeDataSource: UsgsEarthquakeDataSource(Dio()),
    weatherApiDataSource: primary,
    openWeatherDataSource: fallback,
  );
}

void main() {
  group('AlertsRepositoryImpl weather fallback', () {
    test('returns the primary source without touching the fallback', () async {
      final primary = _FakeWeatherDataSource(result: _snapshot(30));
      final fallback = _FakeWeatherDataSource(result: _snapshot(20));

      final snapshot = await _repository(
        primary: primary,
        fallback: fallback,
      ).fetchCurrentWeather();

      expect(snapshot.temperatureC, 30);
      expect(primary.calls, 1);
      expect(fallback.calls, 0);
    });

    test('uses the fallback when the primary source fails', () async {
      final primary = _FakeWeatherDataSource(
        error: const ParsingFailure(message: 'Respuesta inválida'),
      );
      final fallback = _FakeWeatherDataSource(result: _snapshot(20));

      final snapshot = await _repository(
        primary: primary,
        fallback: fallback,
      ).fetchCurrentWeather();

      expect(snapshot.temperatureC, 20);
      expect(primary.calls, 1);
      expect(fallback.calls, 1);
    });

    test('rethrows the first error when both sources fail', () async {
      final primary = _FakeWeatherDataSource(
        error: const ParsingFailure(message: 'Primera falla'),
      );
      final fallback = _FakeWeatherDataSource(
        error: const NetworkFailure(message: 'Segunda falla'),
      );

      await expectLater(
        _repository(primary: primary, fallback: fallback).fetchCurrentWeather(),
        throwsA(
          isA<ParsingFailure>().having(
            (failure) => failure.message,
            'message',
            'Primera falla',
          ),
        ),
      );

      expect(primary.calls, 1);
      expect(fallback.calls, 1);
    });

    test(
      'fails with a configuration error when no source is available',
      () async {
        await expectLater(
          _repository().fetchCurrentWeather(),
          throwsA(isA<ConfigurationFailure>()),
        );
      },
    );
  });
}

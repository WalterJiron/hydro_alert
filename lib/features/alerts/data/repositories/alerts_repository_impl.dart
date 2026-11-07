import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/network_providers.dart';
import '../../domain/entities/seismic_event.dart';
import '../../domain/entities/weather_snapshot.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../datasources/openweather_datasource.dart';
import '../datasources/usgs_earthquake_datasource.dart';
import '../datasources/weather_data_source.dart';
import '../datasources/weatherapi_datasource.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  const AlertsRepositoryImpl({
    required this.earthquakeDataSource,
    this.weatherApiDataSource,
    this.openWeatherDataSource,
  });

  final UsgsEarthquakeDataSource earthquakeDataSource;

  /// Primary weather source.
  final WeatherDataSource? weatherApiDataSource;

  /// Optional fallback used when the primary source fails.
  final WeatherDataSource? openWeatherDataSource;

  @override
  Future<List<SeismicEvent>> fetchRecentEarthquakes() {
    return earthquakeDataSource.fetchRecentEarthquakes();
  }

  @override
  Future<WeatherSnapshot> fetchCurrentWeather({
    double latitude = AppConfig.defaultLatitude,
    double longitude = AppConfig.defaultLongitude,
  }) async {
    final sources = <WeatherDataSource>[
      ?weatherApiDataSource,
      ?openWeatherDataSource,
    ];
    if (sources.isEmpty) {
      throw const ConfigurationFailure(
        message: 'La información meteorológica todavía no está configurada.',
      );
    }

    Object? firstError;
    StackTrace? firstStackTrace;
    for (final source in sources) {
      try {
        return await source.fetchCurrentWeather(
          latitude: latitude,
          longitude: longitude,
        );
      } catch (error, stackTrace) {
        firstError ??= error;
        firstStackTrace ??= stackTrace;
      }
    }

    Error.throwWithStackTrace(firstError!, firstStackTrace!);
  }
}

final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
  return AlertsRepositoryImpl(
    earthquakeDataSource: UsgsEarthquakeDataSource(ref.watch(usgsDioProvider)),
    weatherApiDataSource: AppConfig.hasWeatherApi
        ? WeatherApiDataSource(ref.watch(weatherApiDioProvider))
        : null,
    openWeatherDataSource: AppConfig.hasOpenWeather
        ? OpenWeatherDataSource(ref.watch(openWeatherDioProvider))
        : null,
  );
});

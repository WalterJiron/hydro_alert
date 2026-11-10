import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/network_providers.dart';
import '../../domain/entities/seismic_event.dart';
import '../../domain/entities/weather_snapshot.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../datasources/ineter_seismic_datasource.dart';
import '../datasources/openweather_datasource.dart';
import '../datasources/usgs_earthquake_datasource.dart';
import '../datasources/weather_data_source.dart';
import '../datasources/weatherapi_datasource.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  const AlertsRepositoryImpl({
    required this.earthquakeDataSource,
    this.ineterDataSource,
    this.weatherApiDataSource,
    this.openWeatherDataSource,
  });

  /// USGS fallback, used when the backend/INETER is unavailable.
  final UsgsEarthquakeDataSource earthquakeDataSource;

  /// Primary seismic source, provided by the HydroAlert backend.
  final IneterSeismicDataSource? ineterDataSource;

  /// Primary weather source.
  final WeatherDataSource? weatherApiDataSource;

  /// Optional fallback used when the primary source fails.
  final WeatherDataSource? openWeatherDataSource;

  @override
  Future<List<SeismicEvent>> fetchRecentEarthquakes() async {
    final ineter = ineterDataSource;
    if (ineter != null) {
      try {
        return await ineter.fetchRecentSeismicEvents();
      } catch (ineterError, ineterStackTrace) {
        try {
          return await earthquakeDataSource.fetchRecentEarthquakes();
        } catch (_) {
          // Surface the primary source's failure; the fallback also failed.
          Error.throwWithStackTrace(ineterError, ineterStackTrace);
        }
      }
    }

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
    ineterDataSource: AppConfig.hasBackend
        ? IneterSeismicDataSource(ref.watch(backendDioProvider))
        : null,
    weatherApiDataSource: AppConfig.hasWeatherApi
        ? WeatherApiDataSource(ref.watch(weatherApiDioProvider))
        : null,
    openWeatherDataSource: AppConfig.hasOpenWeather
        ? OpenWeatherDataSource(ref.watch(openWeatherDioProvider))
        : null,
  );
});

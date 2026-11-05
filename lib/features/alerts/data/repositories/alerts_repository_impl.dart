import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_providers.dart';
import '../../domain/entities/seismic_event.dart';
import '../../domain/entities/weather_snapshot.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../datasources/openweather_datasource.dart';
import '../datasources/usgs_earthquake_datasource.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  const AlertsRepositoryImpl({
    required this.earthquakeDataSource,
    required this.weatherDataSource,
  });

  final UsgsEarthquakeDataSource earthquakeDataSource;
  final OpenWeatherDataSource weatherDataSource;

  @override
  Future<List<SeismicEvent>> fetchRecentEarthquakes() {
    return earthquakeDataSource.fetchRecentEarthquakes();
  }

  @override
  Future<WeatherSnapshot> fetchCurrentWeather({
    double latitude = 12.136389,
    double longitude = -86.251389,
  }) {
    return weatherDataSource.fetchCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
  return AlertsRepositoryImpl(
    earthquakeDataSource: UsgsEarthquakeDataSource(ref.watch(usgsDioProvider)),
    weatherDataSource: OpenWeatherDataSource(ref.watch(openWeatherDioProvider)),
  );
});

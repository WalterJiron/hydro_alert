import '../entities/seismic_event.dart';
import '../entities/weather_snapshot.dart';

abstract interface class AlertsRepository {
  Future<List<SeismicEvent>> fetchRecentEarthquakes();

  Future<WeatherSnapshot> fetchCurrentWeather({
    double latitude,
    double longitude,
  });
}

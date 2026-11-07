import '../../domain/entities/weather_snapshot.dart';

/// Contract shared by every weather provider supported by the app.
///
/// Keeping the repository behind this interface allows WeatherAPI to be the
/// primary source while OpenWeatherMap remains an optional fallback.
abstract interface class WeatherDataSource {
  Future<WeatherSnapshot> fetchCurrentWeather({
    double latitude,
    double longitude,
  });
}

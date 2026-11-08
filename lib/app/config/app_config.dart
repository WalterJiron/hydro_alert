/// Application configuration loaded at compile time.
///
/// Secrets are never committed to the repository. Provide them with
/// `--dart-define` when running or building the app.
class AppConfig {
  const AppConfig._();

  static const String appName = 'HydroAlert';
  static const String appTagline = 'Información que protege';
  static const String countryName = 'Nicaragua';

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  /// Primary weather provider. Keep it out of the repository and provide it
  /// with `--dart-define=WEATHERAPI_KEY=...`.
  static const String weatherApiKey = String.fromEnvironment(
    'WEATHERAPI_KEY',
    defaultValue: '',
  );

  /// Optional fallback used when WeatherAPI is not configured or fails.
  static const String openWeatherApiKey = String.fromEnvironment(
    'OPENWEATHER_API_KEY',
    defaultValue: '',
  );

  static const bool firebaseEnabled = bool.fromEnvironment(
    'FIREBASE_ENABLED',
    defaultValue: false,
  );

  static const double defaultLatitude = 12.136389;
  static const double defaultLongitude = -86.251389;

  static final double sosMagnitudeThreshold =
      double.tryParse(
        const String.fromEnvironment(
          'SOS_MAGNITUDE_THRESHOLD',
          defaultValue: '5.0',
        ),
      ) ??
      5.0;

  static final int sosEventMaxAgeMinutes =
      int.tryParse(
        const String.fromEnvironment(
          'SOS_EVENT_MAX_AGE_MINUTES',
          defaultValue: '15',
        ),
      ) ??
      15;

  static const double usgsMinMagnitude = 2.5;
  static const int usgsLimit = 50;
  static const int usgsLookbackDays = 30;

  static bool get hasBackend => apiBaseUrl.trim().isNotEmpty;

  static bool get hasWeatherApi => weatherApiKey.trim().isNotEmpty;

  static bool get hasOpenWeather => openWeatherApiKey.trim().isNotEmpty;

  static bool get hasWeather => hasWeatherApi || hasOpenWeather;

  /// Backend base URL ending in `/`, so Dio joins relative paths correctly.
  static String get normalizedApiBaseUrl {
    final value = apiBaseUrl.trim();
    if (value.isEmpty) {
      return '';
    }
    return value.endsWith('/') ? value : '$value/';
  }
}

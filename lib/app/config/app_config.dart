import 'package:flutter/foundation.dart';

import '../constants/api_endpoints.dart';

/// Application configuration loaded at compile time.
///
/// Secrets are never committed to the repository. Provide them with
/// `--dart-define` when running or building the app.
class AppConfig {
  const AppConfig._();

  static const String appName = 'HydroAlert';
  static const String appTagline = 'Información que protege';
  static const String countryName = 'Nicaragua';

  static const String _apiBaseUrlOverride = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  /// Local backend used during development when `API_BASE_URL` is omitted.
  ///
  /// Android emulators reach the host machine through `10.0.2.2`; iOS
  /// simulators, desktop and web use `localhost`.
  static String get defaultApiBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000/api/v1';
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000/api/v1';
    }
    return 'http://localhost:8000/api/v1';
  }

  /// Backend base URL, overridable with
  /// `--dart-define=API_BASE_URL=https://host/api/v1`.
  static String get apiBaseUrl {
    final override = _apiBaseUrlOverride.trim();
    return override.isEmpty ? defaultApiBaseUrl : override;
  }

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

  /// USGS fallback limits. INETER is the primary seismic source.
  static const double usgsMinMagnitude = 2.5;
  static const int usgsLimit = 50;
  static const int usgsLookbackDays = 30;

  /// INETER history requested from the HydroAlert backend.
  static const int ineterPageSize = 100;
  static const int ineterLookbackDays = 30;

  static bool get hasBackend => normalizedApiBaseUrl.isNotEmpty;

  static bool get hasWeatherApi => weatherApiKey.trim().isNotEmpty;

  static bool get hasOpenWeather => openWeatherApiKey.trim().isNotEmpty;

  static bool get hasWeather => hasWeatherApi || hasOpenWeather;

  /// Backend base URL ending in `/`, so Dio joins relative paths correctly.
  ///
  /// If the configured value only contains the host (for example
  /// `http://localhost:8000`), the canonical `/api/v1` prefix is appended.
  static String get normalizedApiBaseUrl {
    var value = apiBaseUrl.trim();
    if (value.isEmpty) {
      return '';
    }

    value = value.replaceAll(RegExp(r'/+$'), '');
    final uri = Uri.tryParse(value);
    if (uri != null && (uri.path.isEmpty || uri.path == '/')) {
      value = '$value/api/v1';
    }

    return '$value/';
  }

  /// Scheme and authority of the backend, used to resolve root-relative media
  /// paths such as `/api/v1/reports/photos/{id}`.
  static String get apiOrigin {
    final uri = Uri.tryParse(normalizedApiBaseUrl);
    if (uri == null || !uri.hasScheme || uri.authority.isEmpty) {
      return '';
    }
    return '${uri.scheme}://${uri.authority}';
  }

  /// Realtime reports/notifications socket (`/api/v1/ws`).
  static Uri? get realtimeWebSocketUri {
    final base = Uri.tryParse(normalizedApiBaseUrl);
    if (base == null || !base.hasScheme || base.authority.isEmpty) {
      return null;
    }

    final path = base.path.replaceAll(RegExp(r'/+$'), '');
    return base.replace(
      scheme: base.scheme == 'https' ? 'wss' : 'ws',
      path: '$path/${ApiEndpoints.realtimeWebSocketPath}',
    );
  }

  /// Resolves absolute URLs and root-relative media paths returned by the
  /// backend. Relative URLs are interpreted against the API origin, never
  /// blindly against the `/api/v1` base path.
  static String? resolveMediaUrl(String? raw) {
    final value = raw?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(value);
    if (uri != null && uri.hasScheme) {
      return value;
    }

    final origin = apiOrigin;
    if (origin.isEmpty) {
      return value;
    }

    if (value.startsWith('//')) {
      final scheme = Uri.parse(origin).scheme;
      return '$scheme:$value';
    }
    if (value.startsWith('/')) {
      return '$origin$value';
    }
    return '$origin/$value';
  }
}

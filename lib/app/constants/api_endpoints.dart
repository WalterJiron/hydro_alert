/// Centralized external and backend endpoints.
class ApiEndpoints {
  const ApiEndpoints._();

  // USGS FDSN Event Web Service
  static const String usgsBaseUrl = 'https://earthquake.usgs.gov';
  static const String usgsQueryPath = 'fdsnws/event/1/query';

  // WeatherAPI (primary weather source)
  static const String weatherApiBaseUrl = 'https://api.weatherapi.com';
  static const String weatherApiForecastPath = 'v1/forecast.json';

  // OpenWeatherMap One Call API 3.0 (fallback weather source)
  static const String openWeatherBaseUrl = 'https://api.openweathermap.org';
  static const String openWeatherOneCallPath = 'data/3.0/onecall';

  // RainViewer public radar frames
  static const String rainViewerBaseUrl = 'https://api.rainviewer.com';
  static const String rainViewerWeatherMapsPath = 'public/weather-maps.json';

  // HydroAlert backend (FastAPI)
  // Paths are relative because the base URL already contains `/api/v1`.
  static const String reportsPath = 'reports';
  static const String activeReportsPath = 'reports/active';
  static const String authRegisterPath = 'auth/register';
  static const String authLoginPath = 'auth/login';
  static const String seismicEventsPath = 'seismic-events';

  // Realtime reports and emergency notifications.
  static const String realtimeWebSocketPath = 'ws';
  static const String realtimeChannels = 'reports,notifications';

  // Map defaults
  static const double nicaraguaCenterLatitude = 12.8654;
  static const double nicaraguaCenterLongitude = -85.2072;
  static const double nicaraguaSouth = 10.5;
  static const double nicaraguaNorth = 15.2;
  static const double nicaraguaWest = -88.0;
  static const double nicaraguaEast = -82.3;

  // USGS geographic filter for Nicaragua.
  static const double usgsMinLatitude = 10.7;
  static const double usgsMaxLatitude = 15.0;
  static const double usgsMinLongitude = -87.7;
  static const double usgsMaxLongitude = -82.5;

  static const String googleMapsSite = 'https://www.google.com/maps';
  static const String usgsEarthquakeSite = 'https://earthquake.usgs.gov';
  static const String ineterSite =
      'https://www.ineter.gob.ni/articulos/areas-tecnicas/geofisica/monitoreo-de-sismos-en-tiempo-real.html';
  static const String rainViewerSite = 'https://www.rainviewer.com';
}

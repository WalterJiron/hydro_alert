import '../../../../core/errors/app_failure.dart';
import '../domain/entities/weather_alert.dart';
import '../domain/entities/weather_snapshot.dart';
import 'models/weatherapi_model.dart';

/// Rain, snow, drizzle and thunder groups used by WeatherAPI condition codes.
///
/// The groups match the values already understood by `weather_visuals.dart`,
/// so the UI keeps using the same icons and colors as the OpenWeatherMap path.
const Set<int> _drizzleCodes = {1072, 1150, 1153, 1168, 1171};
const Set<int> _rainCodes = {
  1063,
  1180,
  1183,
  1186,
  1189,
  1192,
  1195,
  1198,
  1201,
  1240,
  1243,
  1246,
};
const Set<int> _snowCodes = {
  1066,
  1069,
  1114,
  1117,
  1204,
  1207,
  1210,
  1213,
  1216,
  1219,
  1222,
  1225,
  1237,
  1249,
  1252,
  1255,
  1258,
  1261,
  1264,
};
const Set<int> _thunderCodes = {1087, 1273, 1276, 1279, 1282};
const Set<int> _mistCodes = {1012, 1030, 1033, 1036, 1039, 1042, 1135, 1147};
const Set<int> _dustCodes = {1015, 1018, 1021, 1024, 1027, 1045, 1048};

/// Maps a WeatherAPI condition code to the shared weather group and icon code.
({String main, String iconCode}) weatherVisualFromCode(
  int code, {
  required bool isDay,
}) {
  if (code == 1000) {
    return (main: 'Clear', iconCode: isDay ? '01d' : '01n');
  }
  if (_thunderCodes.contains(code)) {
    return (main: 'Thunderstorm', iconCode: '11d');
  }
  if (_snowCodes.contains(code)) {
    return (main: 'Snow', iconCode: '13d');
  }
  if (_rainCodes.contains(code)) {
    return (main: 'Rain', iconCode: '10d');
  }
  if (_drizzleCodes.contains(code)) {
    return (main: 'Drizzle', iconCode: '09d');
  }
  if (_mistCodes.contains(code)) {
    return (main: 'Mist', iconCode: '50d');
  }
  if (_dustCodes.contains(code)) {
    return (main: 'Dust', iconCode: '50d');
  }
  return (main: 'Clouds', iconCode: '03d');
}

/// Converts a WeatherAPI response into the domain snapshot used by the UI.
WeatherSnapshot weatherSnapshotFromApi(
  WeatherApiResponse model, {
  required double fallbackLatitude,
  required double fallbackLongitude,
}) {
  final current = model.current;
  final temperature = current.temperatureC;
  if (temperature == null) {
    throw const ParsingFailure(
      message: 'La respuesta del clima no incluye la temperatura actual.',
    );
  }

  final isDay = (current.isDay ?? 1) == 1;
  final visual = weatherVisualFromCode(
    current.condition?.code ?? 1000,
    isDay: isDay,
  );
  final observedAt = current.lastUpdatedEpoch == null
      ? DateTime.now()
      : DateTime.fromMillisecondsSinceEpoch(
          current.lastUpdatedEpoch! * 1000,
          isUtc: true,
        ).toLocal();
  final condition = current.condition?.text?.trim();

  return WeatherSnapshot(
    temperatureC: temperature,
    feelsLikeC: current.feelsLikeC ?? temperature,
    humidity: current.humidity ?? 0,
    condition: condition?.isNotEmpty == true
        ? condition!
        : 'Condición no disponible',
    weatherMain: visual.main,
    iconCode: visual.iconCode,
    observedAt: observedAt,
    latitude: model.location?.lat ?? fallbackLatitude,
    longitude: model.location?.lon ?? fallbackLongitude,
    rainLastHourMm: current.precipitationMm,
    alerts: (model.alerts?.alert ?? const <WeatherApiAlert>[])
        .map(_toWeatherAlert)
        .whereType<WeatherAlert>()
        .toList(),
  );
}

WeatherAlert? _toWeatherAlert(WeatherApiAlert alert) {
  final start = DateTime.tryParse(alert.effective?.trim() ?? '');
  final end = DateTime.tryParse(alert.expires?.trim() ?? '');
  if (start == null || end == null) {
    return null;
  }

  final desc = alert.desc?.trim() ?? '';
  final instruction = alert.instruction?.trim() ?? '';
  final event = alert.event?.trim().isNotEmpty == true
      ? alert.event!.trim()
      : (alert.headline?.trim().isNotEmpty == true
            ? alert.headline!.trim()
            : 'Aviso meteorológico');

  return WeatherAlert(
    senderName: 'WeatherAPI',
    event: event,
    start: start.toLocal(),
    end: end.toLocal(),
    description: desc.isNotEmpty ? desc : instruction,
  );
}

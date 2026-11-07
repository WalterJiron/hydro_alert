import 'package:freezed_annotation/freezed_annotation.dart';

part 'weatherapi_model.freezed.dart';
part 'weatherapi_model.g.dart';

double? _asDouble(Object? value) {
  return value is num ? value.toDouble() : null;
}

int? _asInt(Object? value) {
  return value is num ? value.toInt() : null;
}

/// Response of WeatherAPI `v1/forecast.json`.
@freezed
abstract class WeatherApiResponse with _$WeatherApiResponse {
  const factory WeatherApiResponse({
    WeatherApiLocation? location,
    required WeatherApiCurrent current,
    WeatherApiAlerts? alerts,
  }) = _WeatherApiResponse;

  factory WeatherApiResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiResponseFromJson(json);
}

@freezed
abstract class WeatherApiLocation with _$WeatherApiLocation {
  const factory WeatherApiLocation({
    String? name,
    @JsonKey(fromJson: _asDouble) double? lat,
    @JsonKey(fromJson: _asDouble) double? lon,
    @JsonKey(name: 'tz_id') String? timezoneId,
  }) = _WeatherApiLocation;

  factory WeatherApiLocation.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiLocationFromJson(json);
}

@freezed
abstract class WeatherApiCurrent with _$WeatherApiCurrent {
  const factory WeatherApiCurrent({
    @JsonKey(name: 'last_updated_epoch', fromJson: _asInt)
    int? lastUpdatedEpoch,
    @JsonKey(name: 'temp_c', fromJson: _asDouble) double? temperatureC,
    @JsonKey(name: 'feelslike_c', fromJson: _asDouble) double? feelsLikeC,
    @JsonKey(fromJson: _asInt) int? humidity,
    @JsonKey(name: 'is_day', fromJson: _asInt) int? isDay,
    @JsonKey(name: 'precip_mm', fromJson: _asDouble) double? precipitationMm,
    WeatherApiCondition? condition,
  }) = _WeatherApiCurrent;

  factory WeatherApiCurrent.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiCurrentFromJson(json);
}

@freezed
abstract class WeatherApiCondition with _$WeatherApiCondition {
  const factory WeatherApiCondition({
    String? text,
    String? icon,
    @JsonKey(fromJson: _asInt) int? code,
  }) = _WeatherApiCondition;

  factory WeatherApiCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiConditionFromJson(json);
}

@freezed
abstract class WeatherApiAlerts with _$WeatherApiAlerts {
  const factory WeatherApiAlerts({
    @Default(<WeatherApiAlert>[]) List<WeatherApiAlert> alert,
  }) = _WeatherApiAlerts;

  factory WeatherApiAlerts.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiAlertsFromJson(json);
}

@freezed
abstract class WeatherApiAlert with _$WeatherApiAlert {
  const factory WeatherApiAlert({
    String? headline,
    String? event,
    String? effective,
    String? expires,
    String? desc,
    String? instruction,
  }) = _WeatherApiAlert;

  factory WeatherApiAlert.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiAlertFromJson(json);
}

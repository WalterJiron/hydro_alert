import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

double? _asDouble(Object? value) {
  return value is num ? value.toDouble() : null;
}

int? _asInt(Object? value) {
  return value is num ? value.toInt() : null;
}

@freezed
abstract class OpenWeatherResponse with _$OpenWeatherResponse {
  const factory OpenWeatherResponse({
    double? lat,
    double? lon,
    String? timezone,
    required OpenWeatherCurrent current,
    @Default(<OpenWeatherAlert>[]) List<OpenWeatherAlert> alerts,
  }) = _OpenWeatherResponse;

  factory OpenWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenWeatherResponseFromJson(json);
}

@freezed
abstract class OpenWeatherCurrent with _$OpenWeatherCurrent {
  const factory OpenWeatherCurrent({
    int? dt,
    @JsonKey(fromJson: _asDouble) double? temp,
    @JsonKey(name: 'feels_like', fromJson: _asDouble) double? feelsLike,
    @JsonKey(fromJson: _asInt) int? humidity,
    @Default(<OpenWeatherCondition>[]) List<OpenWeatherCondition> weather,
    OpenWeatherRain? rain,
  }) = _OpenWeatherCurrent;

  factory OpenWeatherCurrent.fromJson(Map<String, dynamic> json) =>
      _$OpenWeatherCurrentFromJson(json);
}

@freezed
abstract class OpenWeatherCondition with _$OpenWeatherCondition {
  const factory OpenWeatherCondition({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) = _OpenWeatherCondition;

  factory OpenWeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$OpenWeatherConditionFromJson(json);
}

@freezed
abstract class OpenWeatherRain with _$OpenWeatherRain {
  const factory OpenWeatherRain({
    @JsonKey(name: '1h', fromJson: _asDouble) double? oneHour,
    @JsonKey(name: '3h', fromJson: _asDouble) double? threeHours,
  }) = _OpenWeatherRain;

  factory OpenWeatherRain.fromJson(Map<String, dynamic> json) =>
      _$OpenWeatherRainFromJson(json);
}

@freezed
abstract class OpenWeatherAlert with _$OpenWeatherAlert {
  const factory OpenWeatherAlert({
    @JsonKey(name: 'sender_name') String? senderName,
    String? event,
    int? start,
    int? end,
    String? description,
    @Default(<String>[]) List<String> tags,
  }) = _OpenWeatherAlert;

  factory OpenWeatherAlert.fromJson(Map<String, dynamic> json) =>
      _$OpenWeatherAlertFromJson(json);
}

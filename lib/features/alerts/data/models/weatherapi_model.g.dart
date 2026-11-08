// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weatherapi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherApiResponse _$WeatherApiResponseFromJson(
  Map<String, dynamic> json,
) => _WeatherApiResponse(
  location: json['location'] == null
      ? null
      : WeatherApiLocation.fromJson(json['location'] as Map<String, dynamic>),
  current: WeatherApiCurrent.fromJson(json['current'] as Map<String, dynamic>),
  alerts: json['alerts'] == null
      ? null
      : WeatherApiAlerts.fromJson(json['alerts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeatherApiResponseToJson(_WeatherApiResponse instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
      'alerts': instance.alerts,
    };

_WeatherApiLocation _$WeatherApiLocationFromJson(Map<String, dynamic> json) =>
    _WeatherApiLocation(
      name: json['name'] as String?,
      lat: _asDouble(json['lat']),
      lon: _asDouble(json['lon']),
      timezoneId: json['tz_id'] as String?,
    );

Map<String, dynamic> _$WeatherApiLocationToJson(_WeatherApiLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'tz_id': instance.timezoneId,
    };

_WeatherApiCurrent _$WeatherApiCurrentFromJson(Map<String, dynamic> json) =>
    _WeatherApiCurrent(
      lastUpdatedEpoch: _asInt(json['last_updated_epoch']),
      temperatureC: _asDouble(json['temp_c']),
      feelsLikeC: _asDouble(json['feelslike_c']),
      humidity: _asInt(json['humidity']),
      isDay: _asInt(json['is_day']),
      precipitationMm: _asDouble(json['precip_mm']),
      condition: json['condition'] == null
          ? null
          : WeatherApiCondition.fromJson(
              json['condition'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$WeatherApiCurrentToJson(_WeatherApiCurrent instance) =>
    <String, dynamic>{
      'last_updated_epoch': instance.lastUpdatedEpoch,
      'temp_c': instance.temperatureC,
      'feelslike_c': instance.feelsLikeC,
      'humidity': instance.humidity,
      'is_day': instance.isDay,
      'precip_mm': instance.precipitationMm,
      'condition': instance.condition,
    };

_WeatherApiCondition _$WeatherApiConditionFromJson(Map<String, dynamic> json) =>
    _WeatherApiCondition(
      text: json['text'] as String?,
      icon: json['icon'] as String?,
      code: _asInt(json['code']),
    );

Map<String, dynamic> _$WeatherApiConditionToJson(
  _WeatherApiCondition instance,
) => <String, dynamic>{
  'text': instance.text,
  'icon': instance.icon,
  'code': instance.code,
};

_WeatherApiAlerts _$WeatherApiAlertsFromJson(Map<String, dynamic> json) =>
    _WeatherApiAlerts(
      alert:
          (json['alert'] as List<dynamic>?)
              ?.map((e) => WeatherApiAlert.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WeatherApiAlert>[],
    );

Map<String, dynamic> _$WeatherApiAlertsToJson(_WeatherApiAlerts instance) =>
    <String, dynamic>{'alert': instance.alert};

_WeatherApiAlert _$WeatherApiAlertFromJson(Map<String, dynamic> json) =>
    _WeatherApiAlert(
      headline: json['headline'] as String?,
      event: json['event'] as String?,
      effective: json['effective'] as String?,
      expires: json['expires'] as String?,
      desc: json['desc'] as String?,
      instruction: json['instruction'] as String?,
    );

Map<String, dynamic> _$WeatherApiAlertToJson(_WeatherApiAlert instance) =>
    <String, dynamic>{
      'headline': instance.headline,
      'event': instance.event,
      'effective': instance.effective,
      'expires': instance.expires,
      'desc': instance.desc,
      'instruction': instance.instruction,
    };

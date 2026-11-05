// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpenWeatherResponse _$OpenWeatherResponseFromJson(Map<String, dynamic> json) =>
    _OpenWeatherResponse(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      timezone: json['timezone'] as String?,
      current: OpenWeatherCurrent.fromJson(
        json['current'] as Map<String, dynamic>,
      ),
      alerts:
          (json['alerts'] as List<dynamic>?)
              ?.map((e) => OpenWeatherAlert.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OpenWeatherAlert>[],
    );

Map<String, dynamic> _$OpenWeatherResponseToJson(
  _OpenWeatherResponse instance,
) => <String, dynamic>{
  'lat': instance.lat,
  'lon': instance.lon,
  'timezone': instance.timezone,
  'current': instance.current,
  'alerts': instance.alerts,
};

_OpenWeatherCurrent _$OpenWeatherCurrentFromJson(Map<String, dynamic> json) =>
    _OpenWeatherCurrent(
      dt: (json['dt'] as num?)?.toInt(),
      temp: _asDouble(json['temp']),
      feelsLike: _asDouble(json['feels_like']),
      humidity: _asInt(json['humidity']),
      weather:
          (json['weather'] as List<dynamic>?)
              ?.map(
                (e) => OpenWeatherCondition.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <OpenWeatherCondition>[],
      rain: json['rain'] == null
          ? null
          : OpenWeatherRain.fromJson(json['rain'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenWeatherCurrentToJson(_OpenWeatherCurrent instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'humidity': instance.humidity,
      'weather': instance.weather,
      'rain': instance.rain,
    };

_OpenWeatherCondition _$OpenWeatherConditionFromJson(
  Map<String, dynamic> json,
) => _OpenWeatherCondition(
  id: (json['id'] as num?)?.toInt(),
  main: json['main'] as String?,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$OpenWeatherConditionToJson(
  _OpenWeatherCondition instance,
) => <String, dynamic>{
  'id': instance.id,
  'main': instance.main,
  'description': instance.description,
  'icon': instance.icon,
};

_OpenWeatherRain _$OpenWeatherRainFromJson(Map<String, dynamic> json) =>
    _OpenWeatherRain(
      oneHour: _asDouble(json['1h']),
      threeHours: _asDouble(json['3h']),
    );

Map<String, dynamic> _$OpenWeatherRainToJson(_OpenWeatherRain instance) =>
    <String, dynamic>{'1h': instance.oneHour, '3h': instance.threeHours};

_OpenWeatherAlert _$OpenWeatherAlertFromJson(Map<String, dynamic> json) =>
    _OpenWeatherAlert(
      senderName: json['sender_name'] as String?,
      event: json['event'] as String?,
      start: (json['start'] as num?)?.toInt(),
      end: (json['end'] as num?)?.toInt(),
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$OpenWeatherAlertToJson(_OpenWeatherAlert instance) =>
    <String, dynamic>{
      'sender_name': instance.senderName,
      'event': instance.event,
      'start': instance.start,
      'end': instance.end,
      'description': instance.description,
      'tags': instance.tags,
    };

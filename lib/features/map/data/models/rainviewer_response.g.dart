// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rainviewer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RainViewerResponse _$RainViewerResponseFromJson(Map<String, dynamic> json) =>
    _RainViewerResponse(
      version: json['version'] as String?,
      generated: (json['generated'] as num?)?.toInt(),
      host: json['host'] as String?,
      radar: json['radar'] == null
          ? null
          : RainViewerRadar.fromJson(json['radar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RainViewerResponseToJson(_RainViewerResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'generated': instance.generated,
      'host': instance.host,
      'radar': instance.radar,
    };

_RainViewerRadar _$RainViewerRadarFromJson(Map<String, dynamic> json) =>
    _RainViewerRadar(
      past:
          (json['past'] as List<dynamic>?)
              ?.map((e) => RainViewerFrame.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RainViewerFrame>[],
      nowcast:
          (json['nowcast'] as List<dynamic>?)
              ?.map((e) => RainViewerFrame.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RainViewerFrame>[],
    );

Map<String, dynamic> _$RainViewerRadarToJson(_RainViewerRadar instance) =>
    <String, dynamic>{'past': instance.past, 'nowcast': instance.nowcast};

_RainViewerFrame _$RainViewerFrameFromJson(Map<String, dynamic> json) =>
    _RainViewerFrame(
      time: (json['time'] as num?)?.toInt(),
      path: json['path'] as String?,
    );

Map<String, dynamic> _$RainViewerFrameToJson(_RainViewerFrame instance) =>
    <String, dynamic>{'time': instance.time, 'path': instance.path};

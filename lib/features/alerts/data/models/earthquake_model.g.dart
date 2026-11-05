// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earthquake_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UsgsFeatureCollection _$UsgsFeatureCollectionFromJson(
  Map<String, dynamic> json,
) => _UsgsFeatureCollection(
  features:
      (json['features'] as List<dynamic>?)
          ?.map((e) => UsgsFeature.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <UsgsFeature>[],
);

Map<String, dynamic> _$UsgsFeatureCollectionToJson(
  _UsgsFeatureCollection instance,
) => <String, dynamic>{'features': instance.features};

_UsgsFeature _$UsgsFeatureFromJson(Map<String, dynamic> json) => _UsgsFeature(
  id: json['id'] as String,
  properties: UsgsProperties.fromJson(
    json['properties'] as Map<String, dynamic>,
  ),
  geometry: UsgsGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UsgsFeatureToJson(_UsgsFeature instance) =>
    <String, dynamic>{
      'id': instance.id,
      'properties': instance.properties,
      'geometry': instance.geometry,
    };

_UsgsProperties _$UsgsPropertiesFromJson(Map<String, dynamic> json) =>
    _UsgsProperties(
      mag: _asDouble(json['mag']),
      place: json['place'] as String?,
      time: (json['time'] as num?)?.toInt(),
      alert: json['alert'] as String?,
      status: json['status'] as String?,
      tsunami: (json['tsunami'] as num?)?.toInt(),
      title: json['title'] as String?,
      url: json['url'] as String?,
      sig: (json['sig'] as num?)?.toInt(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UsgsPropertiesToJson(_UsgsProperties instance) =>
    <String, dynamic>{
      'mag': instance.mag,
      'place': instance.place,
      'time': instance.time,
      'alert': instance.alert,
      'status': instance.status,
      'tsunami': instance.tsunami,
      'title': instance.title,
      'url': instance.url,
      'sig': instance.sig,
      'type': instance.type,
    };

_UsgsGeometry _$UsgsGeometryFromJson(Map<String, dynamic> json) =>
    _UsgsGeometry(
      coordinates: json['coordinates'] == null
          ? const <double>[]
          : _asCoordinates(json['coordinates']),
    );

Map<String, dynamic> _$UsgsGeometryToJson(_UsgsGeometry instance) =>
    <String, dynamic>{'coordinates': instance.coordinates};

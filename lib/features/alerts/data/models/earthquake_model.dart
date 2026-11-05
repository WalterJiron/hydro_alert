import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_model.freezed.dart';
part 'earthquake_model.g.dart';

double? _asDouble(Object? value) {
  return value is num ? value.toDouble() : null;
}

List<double> _asCoordinates(Object? value) {
  if (value is! List) {
    return const <double>[];
  }
  return value.whereType<num>().map((value) => value.toDouble()).toList();
}

@freezed
abstract class UsgsFeatureCollection with _$UsgsFeatureCollection {
  const factory UsgsFeatureCollection({
    @Default(<UsgsFeature>[]) List<UsgsFeature> features,
  }) = _UsgsFeatureCollection;

  factory UsgsFeatureCollection.fromJson(Map<String, dynamic> json) =>
      _$UsgsFeatureCollectionFromJson(json);
}

@freezed
abstract class UsgsFeature with _$UsgsFeature {
  const factory UsgsFeature({
    required String id,
    required UsgsProperties properties,
    required UsgsGeometry geometry,
  }) = _UsgsFeature;

  factory UsgsFeature.fromJson(Map<String, dynamic> json) =>
      _$UsgsFeatureFromJson(json);
}

@freezed
abstract class UsgsProperties with _$UsgsProperties {
  const factory UsgsProperties({
    @JsonKey(fromJson: _asDouble) double? mag,
    String? place,
    int? time,
    String? alert,
    String? status,
    int? tsunami,
    String? title,
    String? url,
    int? sig,
    String? type,
  }) = _UsgsProperties;

  factory UsgsProperties.fromJson(Map<String, dynamic> json) =>
      _$UsgsPropertiesFromJson(json);
}

@freezed
abstract class UsgsGeometry with _$UsgsGeometry {
  const factory UsgsGeometry({
    @JsonKey(fromJson: _asCoordinates)
    @Default(<double>[])
    List<double> coordinates,
  }) = _UsgsGeometry;

  factory UsgsGeometry.fromJson(Map<String, dynamic> json) =>
      _$UsgsGeometryFromJson(json);
}

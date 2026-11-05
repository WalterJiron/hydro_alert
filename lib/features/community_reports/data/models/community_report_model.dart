import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_report_model.freezed.dart';
part 'community_report_model.g.dart';

DateTime _requiredDateTime(Object? value) {
  if (value is String) {
    final parsed = DateTime.tryParse(value);
    if (parsed != null) {
      return parsed;
    }
  }
  if (value is num) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true);
  }
  throw const FormatException('Fecha de reporte inválida.');
}

double _requiredDouble(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    final parsed = double.tryParse(value);
    if (parsed != null) {
      return parsed;
    }
  }
  throw const FormatException('Coordenada de reporte inválida.');
}

@freezed
abstract class CommunityReportModel with _$CommunityReportModel {
  const factory CommunityReportModel({
    @JsonKey(readValue: _readId) required String id,
    required String category,
    @Default('') String description,
    @JsonKey(fromJson: _requiredDouble) required double latitude,
    @JsonKey(fromJson: _requiredDouble) required double longitude,
    @JsonKey(readValue: _readPhotoUrl) String? photoUrl,
    @JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime)
    required DateTime createdAt,
    @Default('active') String status,
  }) = _CommunityReportModel;

  factory CommunityReportModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityReportModelFromJson(json);
}

Object? _readId(Map<dynamic, dynamic> json, String key) {
  return json['id'] ?? json['_id'];
}

Object? _readPhotoUrl(Map<dynamic, dynamic> json, String key) {
  return json['photoUrl'] ?? json['photo_url'];
}

Object? _readCreatedAt(Map<dynamic, dynamic> json, String key) {
  return json['createdAt'] ?? json['created_at'];
}

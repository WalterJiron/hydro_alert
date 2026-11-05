// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunityReportModel _$CommunityReportModelFromJson(
  Map<String, dynamic> json,
) => _CommunityReportModel(
  id: _readId(json, 'id') as String,
  category: json['category'] as String,
  description: json['description'] as String? ?? '',
  latitude: _requiredDouble(json['latitude']),
  longitude: _requiredDouble(json['longitude']),
  photoUrl: _readPhotoUrl(json, 'photoUrl') as String?,
  createdAt: _requiredDateTime(_readCreatedAt(json, 'createdAt')),
  status: json['status'] as String? ?? 'active',
);

Map<String, dynamic> _$CommunityReportModelToJson(
  _CommunityReportModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'description': instance.description,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'photoUrl': instance.photoUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'status': instance.status,
};

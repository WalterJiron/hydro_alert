// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityReportModel {

@JsonKey(readValue: _readId) String get id; String get category; String get description;@JsonKey(fromJson: _requiredDouble) double get latitude;@JsonKey(fromJson: _requiredDouble) double get longitude;@JsonKey(readValue: _readPhotoUrl) String? get photoUrl;@JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime) DateTime get createdAt; String get status;
/// Create a copy of CommunityReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityReportModelCopyWith<CommunityReportModel> get copyWith => _$CommunityReportModelCopyWithImpl<CommunityReportModel>(this as CommunityReportModel, _$identity);

  /// Serializes this CommunityReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,description,latitude,longitude,photoUrl,createdAt,status);

@override
String toString() {
  return 'CommunityReportModel(id: $id, category: $category, description: $description, latitude: $latitude, longitude: $longitude, photoUrl: $photoUrl, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $CommunityReportModelCopyWith<$Res>  {
  factory $CommunityReportModelCopyWith(CommunityReportModel value, $Res Function(CommunityReportModel) _then) = _$CommunityReportModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readId) String id, String category, String description,@JsonKey(fromJson: _requiredDouble) double latitude,@JsonKey(fromJson: _requiredDouble) double longitude,@JsonKey(readValue: _readPhotoUrl) String? photoUrl,@JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime) DateTime createdAt, String status
});




}
/// @nodoc
class _$CommunityReportModelCopyWithImpl<$Res>
    implements $CommunityReportModelCopyWith<$Res> {
  _$CommunityReportModelCopyWithImpl(this._self, this._then);

  final CommunityReportModel _self;
  final $Res Function(CommunityReportModel) _then;

/// Create a copy of CommunityReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? description = null,Object? latitude = null,Object? longitude = null,Object? photoUrl = freezed,Object? createdAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityReportModel].
extension CommunityReportModelPatterns on CommunityReportModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityReportModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityReportModel value)  $default,){
final _that = this;
switch (_that) {
case _CommunityReportModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityReportModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String id,  String category,  String description, @JsonKey(fromJson: _requiredDouble)  double latitude, @JsonKey(fromJson: _requiredDouble)  double longitude, @JsonKey(readValue: _readPhotoUrl)  String? photoUrl, @JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime)  DateTime createdAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityReportModel() when $default != null:
return $default(_that.id,_that.category,_that.description,_that.latitude,_that.longitude,_that.photoUrl,_that.createdAt,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String id,  String category,  String description, @JsonKey(fromJson: _requiredDouble)  double latitude, @JsonKey(fromJson: _requiredDouble)  double longitude, @JsonKey(readValue: _readPhotoUrl)  String? photoUrl, @JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime)  DateTime createdAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _CommunityReportModel():
return $default(_that.id,_that.category,_that.description,_that.latitude,_that.longitude,_that.photoUrl,_that.createdAt,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readId)  String id,  String category,  String description, @JsonKey(fromJson: _requiredDouble)  double latitude, @JsonKey(fromJson: _requiredDouble)  double longitude, @JsonKey(readValue: _readPhotoUrl)  String? photoUrl, @JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime)  DateTime createdAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _CommunityReportModel() when $default != null:
return $default(_that.id,_that.category,_that.description,_that.latitude,_that.longitude,_that.photoUrl,_that.createdAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityReportModel implements CommunityReportModel {
  const _CommunityReportModel({@JsonKey(readValue: _readId) required this.id, required this.category, this.description = '', @JsonKey(fromJson: _requiredDouble) required this.latitude, @JsonKey(fromJson: _requiredDouble) required this.longitude, @JsonKey(readValue: _readPhotoUrl) this.photoUrl, @JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime) required this.createdAt, this.status = 'active'});
  factory _CommunityReportModel.fromJson(Map<String, dynamic> json) => _$CommunityReportModelFromJson(json);

@override@JsonKey(readValue: _readId) final  String id;
@override final  String category;
@override@JsonKey() final  String description;
@override@JsonKey(fromJson: _requiredDouble) final  double latitude;
@override@JsonKey(fromJson: _requiredDouble) final  double longitude;
@override@JsonKey(readValue: _readPhotoUrl) final  String? photoUrl;
@override@JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime) final  DateTime createdAt;
@override@JsonKey() final  String status;

/// Create a copy of CommunityReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityReportModelCopyWith<_CommunityReportModel> get copyWith => __$CommunityReportModelCopyWithImpl<_CommunityReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,description,latitude,longitude,photoUrl,createdAt,status);

@override
String toString() {
  return 'CommunityReportModel(id: $id, category: $category, description: $description, latitude: $latitude, longitude: $longitude, photoUrl: $photoUrl, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CommunityReportModelCopyWith<$Res> implements $CommunityReportModelCopyWith<$Res> {
  factory _$CommunityReportModelCopyWith(_CommunityReportModel value, $Res Function(_CommunityReportModel) _then) = __$CommunityReportModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readId) String id, String category, String description,@JsonKey(fromJson: _requiredDouble) double latitude,@JsonKey(fromJson: _requiredDouble) double longitude,@JsonKey(readValue: _readPhotoUrl) String? photoUrl,@JsonKey(readValue: _readCreatedAt, fromJson: _requiredDateTime) DateTime createdAt, String status
});




}
/// @nodoc
class __$CommunityReportModelCopyWithImpl<$Res>
    implements _$CommunityReportModelCopyWith<$Res> {
  __$CommunityReportModelCopyWithImpl(this._self, this._then);

  final _CommunityReportModel _self;
  final $Res Function(_CommunityReportModel) _then;

/// Create a copy of CommunityReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? description = null,Object? latitude = null,Object? longitude = null,Object? photoUrl = freezed,Object? createdAt = null,Object? status = null,}) {
  return _then(_CommunityReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityReport {

 String get id; ReportCategory get category; String get description; double get latitude; double get longitude; DateTime get createdAt; String? get photoUrl; bool get isVerified;
/// Create a copy of CommunityReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityReportCopyWith<CommunityReport> get copyWith => _$CommunityReportCopyWithImpl<CommunityReport>(this as CommunityReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityReport&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,id,category,description,latitude,longitude,createdAt,photoUrl,isVerified);

@override
String toString() {
  return 'CommunityReport(id: $id, category: $category, description: $description, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, photoUrl: $photoUrl, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class $CommunityReportCopyWith<$Res>  {
  factory $CommunityReportCopyWith(CommunityReport value, $Res Function(CommunityReport) _then) = _$CommunityReportCopyWithImpl;
@useResult
$Res call({
 String id, ReportCategory category, String description, double latitude, double longitude, DateTime createdAt, String? photoUrl, bool isVerified
});




}
/// @nodoc
class _$CommunityReportCopyWithImpl<$Res>
    implements $CommunityReportCopyWith<$Res> {
  _$CommunityReportCopyWithImpl(this._self, this._then);

  final CommunityReport _self;
  final $Res Function(CommunityReport) _then;

/// Create a copy of CommunityReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? description = null,Object? latitude = null,Object? longitude = null,Object? createdAt = null,Object? photoUrl = freezed,Object? isVerified = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ReportCategory,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityReport].
extension CommunityReportPatterns on CommunityReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityReport value)  $default,){
final _that = this;
switch (_that) {
case _CommunityReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityReport value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ReportCategory category,  String description,  double latitude,  double longitude,  DateTime createdAt,  String? photoUrl,  bool isVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityReport() when $default != null:
return $default(_that.id,_that.category,_that.description,_that.latitude,_that.longitude,_that.createdAt,_that.photoUrl,_that.isVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ReportCategory category,  String description,  double latitude,  double longitude,  DateTime createdAt,  String? photoUrl,  bool isVerified)  $default,) {final _that = this;
switch (_that) {
case _CommunityReport():
return $default(_that.id,_that.category,_that.description,_that.latitude,_that.longitude,_that.createdAt,_that.photoUrl,_that.isVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ReportCategory category,  String description,  double latitude,  double longitude,  DateTime createdAt,  String? photoUrl,  bool isVerified)?  $default,) {final _that = this;
switch (_that) {
case _CommunityReport() when $default != null:
return $default(_that.id,_that.category,_that.description,_that.latitude,_that.longitude,_that.createdAt,_that.photoUrl,_that.isVerified);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityReport extends CommunityReport {
  const _CommunityReport({required this.id, required this.category, required this.description, required this.latitude, required this.longitude, required this.createdAt, this.photoUrl, this.isVerified = false}): super._();
  

@override final  String id;
@override final  ReportCategory category;
@override final  String description;
@override final  double latitude;
@override final  double longitude;
@override final  DateTime createdAt;
@override final  String? photoUrl;
@override@JsonKey() final  bool isVerified;

/// Create a copy of CommunityReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityReportCopyWith<_CommunityReport> get copyWith => __$CommunityReportCopyWithImpl<_CommunityReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityReport&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,id,category,description,latitude,longitude,createdAt,photoUrl,isVerified);

@override
String toString() {
  return 'CommunityReport(id: $id, category: $category, description: $description, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, photoUrl: $photoUrl, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$CommunityReportCopyWith<$Res> implements $CommunityReportCopyWith<$Res> {
  factory _$CommunityReportCopyWith(_CommunityReport value, $Res Function(_CommunityReport) _then) = __$CommunityReportCopyWithImpl;
@override @useResult
$Res call({
 String id, ReportCategory category, String description, double latitude, double longitude, DateTime createdAt, String? photoUrl, bool isVerified
});




}
/// @nodoc
class __$CommunityReportCopyWithImpl<$Res>
    implements _$CommunityReportCopyWith<$Res> {
  __$CommunityReportCopyWithImpl(this._self, this._then);

  final _CommunityReport _self;
  final $Res Function(_CommunityReport) _then;

/// Create a copy of CommunityReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? description = null,Object? latitude = null,Object? longitude = null,Object? createdAt = null,Object? photoUrl = freezed,Object? isVerified = null,}) {
  return _then(_CommunityReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ReportCategory,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

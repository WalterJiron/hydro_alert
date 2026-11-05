// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportDraft {

 ReportCategory? get category; String get description; double? get latitude; double? get longitude; Uint8List? get photoBytes; String? get photoName;
/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDraftCopyWith<ReportDraft> get copyWith => _$ReportDraftCopyWithImpl<ReportDraft>(this as ReportDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportDraft&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.photoBytes, photoBytes)&&(identical(other.photoName, photoName) || other.photoName == photoName));
}


@override
int get hashCode => Object.hash(runtimeType,category,description,latitude,longitude,const DeepCollectionEquality().hash(photoBytes),photoName);

@override
String toString() {
  return 'ReportDraft(category: $category, description: $description, latitude: $latitude, longitude: $longitude, photoBytes: $photoBytes, photoName: $photoName)';
}


}

/// @nodoc
abstract mixin class $ReportDraftCopyWith<$Res>  {
  factory $ReportDraftCopyWith(ReportDraft value, $Res Function(ReportDraft) _then) = _$ReportDraftCopyWithImpl;
@useResult
$Res call({
 ReportCategory? category, String description, double? latitude, double? longitude, Uint8List? photoBytes, String? photoName
});




}
/// @nodoc
class _$ReportDraftCopyWithImpl<$Res>
    implements $ReportDraftCopyWith<$Res> {
  _$ReportDraftCopyWithImpl(this._self, this._then);

  final ReportDraft _self;
  final $Res Function(ReportDraft) _then;

/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? description = null,Object? latitude = freezed,Object? longitude = freezed,Object? photoBytes = freezed,Object? photoName = freezed,}) {
  return _then(_self.copyWith(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ReportCategory?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,photoBytes: freezed == photoBytes ? _self.photoBytes : photoBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,photoName: freezed == photoName ? _self.photoName : photoName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportDraft].
extension ReportDraftPatterns on ReportDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportDraft value)  $default,){
final _that = this;
switch (_that) {
case _ReportDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportDraft value)?  $default,){
final _that = this;
switch (_that) {
case _ReportDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportCategory? category,  String description,  double? latitude,  double? longitude,  Uint8List? photoBytes,  String? photoName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportDraft() when $default != null:
return $default(_that.category,_that.description,_that.latitude,_that.longitude,_that.photoBytes,_that.photoName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportCategory? category,  String description,  double? latitude,  double? longitude,  Uint8List? photoBytes,  String? photoName)  $default,) {final _that = this;
switch (_that) {
case _ReportDraft():
return $default(_that.category,_that.description,_that.latitude,_that.longitude,_that.photoBytes,_that.photoName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportCategory? category,  String description,  double? latitude,  double? longitude,  Uint8List? photoBytes,  String? photoName)?  $default,) {final _that = this;
switch (_that) {
case _ReportDraft() when $default != null:
return $default(_that.category,_that.description,_that.latitude,_that.longitude,_that.photoBytes,_that.photoName);case _:
  return null;

}
}

}

/// @nodoc


class _ReportDraft extends ReportDraft {
  const _ReportDraft({this.category, this.description = '', this.latitude, this.longitude, this.photoBytes, this.photoName}): super._();
  

@override final  ReportCategory? category;
@override@JsonKey() final  String description;
@override final  double? latitude;
@override final  double? longitude;
@override final  Uint8List? photoBytes;
@override final  String? photoName;

/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDraftCopyWith<_ReportDraft> get copyWith => __$ReportDraftCopyWithImpl<_ReportDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportDraft&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.photoBytes, photoBytes)&&(identical(other.photoName, photoName) || other.photoName == photoName));
}


@override
int get hashCode => Object.hash(runtimeType,category,description,latitude,longitude,const DeepCollectionEquality().hash(photoBytes),photoName);

@override
String toString() {
  return 'ReportDraft(category: $category, description: $description, latitude: $latitude, longitude: $longitude, photoBytes: $photoBytes, photoName: $photoName)';
}


}

/// @nodoc
abstract mixin class _$ReportDraftCopyWith<$Res> implements $ReportDraftCopyWith<$Res> {
  factory _$ReportDraftCopyWith(_ReportDraft value, $Res Function(_ReportDraft) _then) = __$ReportDraftCopyWithImpl;
@override @useResult
$Res call({
 ReportCategory? category, String description, double? latitude, double? longitude, Uint8List? photoBytes, String? photoName
});




}
/// @nodoc
class __$ReportDraftCopyWithImpl<$Res>
    implements _$ReportDraftCopyWith<$Res> {
  __$ReportDraftCopyWithImpl(this._self, this._then);

  final _ReportDraft _self;
  final $Res Function(_ReportDraft) _then;

/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? description = null,Object? latitude = freezed,Object? longitude = freezed,Object? photoBytes = freezed,Object? photoName = freezed,}) {
  return _then(_ReportDraft(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ReportCategory?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,photoBytes: freezed == photoBytes ? _self.photoBytes : photoBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,photoName: freezed == photoName ? _self.photoName : photoName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

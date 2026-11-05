// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emergency_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmergencyEvent {

 String get id; EmergencySource get source; String get title; String get message; DateTime get receivedAt; DateTime? get occurredAt; double? get magnitude; String? get place; double? get latitude; double? get longitude; double? get depthKm; String? get externalUrl;
/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyEventCopyWith<EmergencyEvent> get copyWith => _$EmergencyEventCopyWithImpl<EmergencyEvent>(this as EmergencyEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.place, place) || other.place == place)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.externalUrl, externalUrl) || other.externalUrl == externalUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,source,title,message,receivedAt,occurredAt,magnitude,place,latitude,longitude,depthKm,externalUrl);

@override
String toString() {
  return 'EmergencyEvent(id: $id, source: $source, title: $title, message: $message, receivedAt: $receivedAt, occurredAt: $occurredAt, magnitude: $magnitude, place: $place, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, externalUrl: $externalUrl)';
}


}

/// @nodoc
abstract mixin class $EmergencyEventCopyWith<$Res>  {
  factory $EmergencyEventCopyWith(EmergencyEvent value, $Res Function(EmergencyEvent) _then) = _$EmergencyEventCopyWithImpl;
@useResult
$Res call({
 String id, EmergencySource source, String title, String message, DateTime receivedAt, DateTime? occurredAt, double? magnitude, String? place, double? latitude, double? longitude, double? depthKm, String? externalUrl
});




}
/// @nodoc
class _$EmergencyEventCopyWithImpl<$Res>
    implements $EmergencyEventCopyWith<$Res> {
  _$EmergencyEventCopyWithImpl(this._self, this._then);

  final EmergencyEvent _self;
  final $Res Function(EmergencyEvent) _then;

/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? title = null,Object? message = null,Object? receivedAt = null,Object? occurredAt = freezed,Object? magnitude = freezed,Object? place = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? depthKm = freezed,Object? externalUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as EmergencySource,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,occurredAt: freezed == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,externalUrl: freezed == externalUrl ? _self.externalUrl : externalUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmergencyEvent].
extension EmergencyEventPatterns on EmergencyEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmergencyEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmergencyEvent value)  $default,){
final _that = this;
switch (_that) {
case _EmergencyEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmergencyEvent value)?  $default,){
final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  EmergencySource source,  String title,  String message,  DateTime receivedAt,  DateTime? occurredAt,  double? magnitude,  String? place,  double? latitude,  double? longitude,  double? depthKm,  String? externalUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
return $default(_that.id,_that.source,_that.title,_that.message,_that.receivedAt,_that.occurredAt,_that.magnitude,_that.place,_that.latitude,_that.longitude,_that.depthKm,_that.externalUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  EmergencySource source,  String title,  String message,  DateTime receivedAt,  DateTime? occurredAt,  double? magnitude,  String? place,  double? latitude,  double? longitude,  double? depthKm,  String? externalUrl)  $default,) {final _that = this;
switch (_that) {
case _EmergencyEvent():
return $default(_that.id,_that.source,_that.title,_that.message,_that.receivedAt,_that.occurredAt,_that.magnitude,_that.place,_that.latitude,_that.longitude,_that.depthKm,_that.externalUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  EmergencySource source,  String title,  String message,  DateTime receivedAt,  DateTime? occurredAt,  double? magnitude,  String? place,  double? latitude,  double? longitude,  double? depthKm,  String? externalUrl)?  $default,) {final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
return $default(_that.id,_that.source,_that.title,_that.message,_that.receivedAt,_that.occurredAt,_that.magnitude,_that.place,_that.latitude,_that.longitude,_that.depthKm,_that.externalUrl);case _:
  return null;

}
}

}

/// @nodoc


class _EmergencyEvent extends EmergencyEvent {
  const _EmergencyEvent({required this.id, required this.source, required this.title, required this.message, required this.receivedAt, this.occurredAt, this.magnitude, this.place, this.latitude, this.longitude, this.depthKm, this.externalUrl}): super._();
  

@override final  String id;
@override final  EmergencySource source;
@override final  String title;
@override final  String message;
@override final  DateTime receivedAt;
@override final  DateTime? occurredAt;
@override final  double? magnitude;
@override final  String? place;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? depthKm;
@override final  String? externalUrl;

/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmergencyEventCopyWith<_EmergencyEvent> get copyWith => __$EmergencyEventCopyWithImpl<_EmergencyEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmergencyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.place, place) || other.place == place)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.externalUrl, externalUrl) || other.externalUrl == externalUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,source,title,message,receivedAt,occurredAt,magnitude,place,latitude,longitude,depthKm,externalUrl);

@override
String toString() {
  return 'EmergencyEvent(id: $id, source: $source, title: $title, message: $message, receivedAt: $receivedAt, occurredAt: $occurredAt, magnitude: $magnitude, place: $place, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, externalUrl: $externalUrl)';
}


}

/// @nodoc
abstract mixin class _$EmergencyEventCopyWith<$Res> implements $EmergencyEventCopyWith<$Res> {
  factory _$EmergencyEventCopyWith(_EmergencyEvent value, $Res Function(_EmergencyEvent) _then) = __$EmergencyEventCopyWithImpl;
@override @useResult
$Res call({
 String id, EmergencySource source, String title, String message, DateTime receivedAt, DateTime? occurredAt, double? magnitude, String? place, double? latitude, double? longitude, double? depthKm, String? externalUrl
});




}
/// @nodoc
class __$EmergencyEventCopyWithImpl<$Res>
    implements _$EmergencyEventCopyWith<$Res> {
  __$EmergencyEventCopyWithImpl(this._self, this._then);

  final _EmergencyEvent _self;
  final $Res Function(_EmergencyEvent) _then;

/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? title = null,Object? message = null,Object? receivedAt = null,Object? occurredAt = freezed,Object? magnitude = freezed,Object? place = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? depthKm = freezed,Object? externalUrl = freezed,}) {
  return _then(_EmergencyEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as EmergencySource,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,occurredAt: freezed == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,externalUrl: freezed == externalUrl ? _self.externalUrl : externalUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

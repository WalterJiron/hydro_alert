// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismic_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicEvent {

 String get id; double get magnitude; String get place; DateTime get occurredAt; double get latitude; double get longitude; double? get depthKm; String? get url; String? get reviewStatus; bool get tsunami; String get source;
/// Create a copy of SeismicEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicEventCopyWith<SeismicEvent> get copyWith => _$SeismicEventCopyWithImpl<SeismicEvent>(this as SeismicEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.place, place) || other.place == place)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.url, url) || other.url == url)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,magnitude,place,occurredAt,latitude,longitude,depthKm,url,reviewStatus,tsunami,source);

@override
String toString() {
  return 'SeismicEvent(id: $id, magnitude: $magnitude, place: $place, occurredAt: $occurredAt, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, url: $url, reviewStatus: $reviewStatus, tsunami: $tsunami, source: $source)';
}


}

/// @nodoc
abstract mixin class $SeismicEventCopyWith<$Res>  {
  factory $SeismicEventCopyWith(SeismicEvent value, $Res Function(SeismicEvent) _then) = _$SeismicEventCopyWithImpl;
@useResult
$Res call({
 String id, double magnitude, String place, DateTime occurredAt, double latitude, double longitude, double? depthKm, String? url, String? reviewStatus, bool tsunami, String source
});




}
/// @nodoc
class _$SeismicEventCopyWithImpl<$Res>
    implements $SeismicEventCopyWith<$Res> {
  _$SeismicEventCopyWithImpl(this._self, this._then);

  final SeismicEvent _self;
  final $Res Function(SeismicEvent) _then;

/// Create a copy of SeismicEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? magnitude = null,Object? place = null,Object? occurredAt = null,Object? latitude = null,Object? longitude = null,Object? depthKm = freezed,Object? url = freezed,Object? reviewStatus = freezed,Object? tsunami = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,reviewStatus: freezed == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as String?,tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicEvent].
extension SeismicEventPatterns on SeismicEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicEvent value)  $default,){
final _that = this;
switch (_that) {
case _SeismicEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicEvent value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double magnitude,  String place,  DateTime occurredAt,  double latitude,  double longitude,  double? depthKm,  String? url,  String? reviewStatus,  bool tsunami,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicEvent() when $default != null:
return $default(_that.id,_that.magnitude,_that.place,_that.occurredAt,_that.latitude,_that.longitude,_that.depthKm,_that.url,_that.reviewStatus,_that.tsunami,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double magnitude,  String place,  DateTime occurredAt,  double latitude,  double longitude,  double? depthKm,  String? url,  String? reviewStatus,  bool tsunami,  String source)  $default,) {final _that = this;
switch (_that) {
case _SeismicEvent():
return $default(_that.id,_that.magnitude,_that.place,_that.occurredAt,_that.latitude,_that.longitude,_that.depthKm,_that.url,_that.reviewStatus,_that.tsunami,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double magnitude,  String place,  DateTime occurredAt,  double latitude,  double longitude,  double? depthKm,  String? url,  String? reviewStatus,  bool tsunami,  String source)?  $default,) {final _that = this;
switch (_that) {
case _SeismicEvent() when $default != null:
return $default(_that.id,_that.magnitude,_that.place,_that.occurredAt,_that.latitude,_that.longitude,_that.depthKm,_that.url,_that.reviewStatus,_that.tsunami,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicEvent extends SeismicEvent {
  const _SeismicEvent({required this.id, required this.magnitude, required this.place, required this.occurredAt, required this.latitude, required this.longitude, this.depthKm, this.url, this.reviewStatus, this.tsunami = false, this.source = 'USGS'}): super._();
  

@override final  String id;
@override final  double magnitude;
@override final  String place;
@override final  DateTime occurredAt;
@override final  double latitude;
@override final  double longitude;
@override final  double? depthKm;
@override final  String? url;
@override final  String? reviewStatus;
@override@JsonKey() final  bool tsunami;
@override@JsonKey() final  String source;

/// Create a copy of SeismicEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicEventCopyWith<_SeismicEvent> get copyWith => __$SeismicEventCopyWithImpl<_SeismicEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.place, place) || other.place == place)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.url, url) || other.url == url)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,magnitude,place,occurredAt,latitude,longitude,depthKm,url,reviewStatus,tsunami,source);

@override
String toString() {
  return 'SeismicEvent(id: $id, magnitude: $magnitude, place: $place, occurredAt: $occurredAt, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, url: $url, reviewStatus: $reviewStatus, tsunami: $tsunami, source: $source)';
}


}

/// @nodoc
abstract mixin class _$SeismicEventCopyWith<$Res> implements $SeismicEventCopyWith<$Res> {
  factory _$SeismicEventCopyWith(_SeismicEvent value, $Res Function(_SeismicEvent) _then) = __$SeismicEventCopyWithImpl;
@override @useResult
$Res call({
 String id, double magnitude, String place, DateTime occurredAt, double latitude, double longitude, double? depthKm, String? url, String? reviewStatus, bool tsunami, String source
});




}
/// @nodoc
class __$SeismicEventCopyWithImpl<$Res>
    implements _$SeismicEventCopyWith<$Res> {
  __$SeismicEventCopyWithImpl(this._self, this._then);

  final _SeismicEvent _self;
  final $Res Function(_SeismicEvent) _then;

/// Create a copy of SeismicEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? magnitude = null,Object? place = null,Object? occurredAt = null,Object? latitude = null,Object? longitude = null,Object? depthKm = freezed,Object? url = freezed,Object? reviewStatus = freezed,Object? tsunami = null,Object? source = null,}) {
  return _then(_SeismicEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,reviewStatus: freezed == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as String?,tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

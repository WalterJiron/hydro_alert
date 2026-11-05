// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherSnapshot {

 double get temperatureC; double get feelsLikeC; int get humidity; String get condition; String get weatherMain; String get iconCode; DateTime get observedAt; double get latitude; double get longitude; double? get rainLastHourMm; List<WeatherAlert> get alerts;
/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherSnapshotCopyWith<WeatherSnapshot> get copyWith => _$WeatherSnapshotCopyWithImpl<WeatherSnapshot>(this as WeatherSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherSnapshot&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.feelsLikeC, feelsLikeC) || other.feelsLikeC == feelsLikeC)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.weatherMain, weatherMain) || other.weatherMain == weatherMain)&&(identical(other.iconCode, iconCode) || other.iconCode == iconCode)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.rainLastHourMm, rainLastHourMm) || other.rainLastHourMm == rainLastHourMm)&&const DeepCollectionEquality().equals(other.alerts, alerts));
}


@override
int get hashCode => Object.hash(runtimeType,temperatureC,feelsLikeC,humidity,condition,weatherMain,iconCode,observedAt,latitude,longitude,rainLastHourMm,const DeepCollectionEquality().hash(alerts));

@override
String toString() {
  return 'WeatherSnapshot(temperatureC: $temperatureC, feelsLikeC: $feelsLikeC, humidity: $humidity, condition: $condition, weatherMain: $weatherMain, iconCode: $iconCode, observedAt: $observedAt, latitude: $latitude, longitude: $longitude, rainLastHourMm: $rainLastHourMm, alerts: $alerts)';
}


}

/// @nodoc
abstract mixin class $WeatherSnapshotCopyWith<$Res>  {
  factory $WeatherSnapshotCopyWith(WeatherSnapshot value, $Res Function(WeatherSnapshot) _then) = _$WeatherSnapshotCopyWithImpl;
@useResult
$Res call({
 double temperatureC, double feelsLikeC, int humidity, String condition, String weatherMain, String iconCode, DateTime observedAt, double latitude, double longitude, double? rainLastHourMm, List<WeatherAlert> alerts
});




}
/// @nodoc
class _$WeatherSnapshotCopyWithImpl<$Res>
    implements $WeatherSnapshotCopyWith<$Res> {
  _$WeatherSnapshotCopyWithImpl(this._self, this._then);

  final WeatherSnapshot _self;
  final $Res Function(WeatherSnapshot) _then;

/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? temperatureC = null,Object? feelsLikeC = null,Object? humidity = null,Object? condition = null,Object? weatherMain = null,Object? iconCode = null,Object? observedAt = null,Object? latitude = null,Object? longitude = null,Object? rainLastHourMm = freezed,Object? alerts = null,}) {
  return _then(_self.copyWith(
temperatureC: null == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as double,feelsLikeC: null == feelsLikeC ? _self.feelsLikeC : feelsLikeC // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,weatherMain: null == weatherMain ? _self.weatherMain : weatherMain // ignore: cast_nullable_to_non_nullable
as String,iconCode: null == iconCode ? _self.iconCode : iconCode // ignore: cast_nullable_to_non_nullable
as String,observedAt: null == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,rainLastHourMm: freezed == rainLastHourMm ? _self.rainLastHourMm : rainLastHourMm // ignore: cast_nullable_to_non_nullable
as double?,alerts: null == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<WeatherAlert>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherSnapshot].
extension WeatherSnapshotPatterns on WeatherSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _WeatherSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double temperatureC,  double feelsLikeC,  int humidity,  String condition,  String weatherMain,  String iconCode,  DateTime observedAt,  double latitude,  double longitude,  double? rainLastHourMm,  List<WeatherAlert> alerts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
return $default(_that.temperatureC,_that.feelsLikeC,_that.humidity,_that.condition,_that.weatherMain,_that.iconCode,_that.observedAt,_that.latitude,_that.longitude,_that.rainLastHourMm,_that.alerts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double temperatureC,  double feelsLikeC,  int humidity,  String condition,  String weatherMain,  String iconCode,  DateTime observedAt,  double latitude,  double longitude,  double? rainLastHourMm,  List<WeatherAlert> alerts)  $default,) {final _that = this;
switch (_that) {
case _WeatherSnapshot():
return $default(_that.temperatureC,_that.feelsLikeC,_that.humidity,_that.condition,_that.weatherMain,_that.iconCode,_that.observedAt,_that.latitude,_that.longitude,_that.rainLastHourMm,_that.alerts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double temperatureC,  double feelsLikeC,  int humidity,  String condition,  String weatherMain,  String iconCode,  DateTime observedAt,  double latitude,  double longitude,  double? rainLastHourMm,  List<WeatherAlert> alerts)?  $default,) {final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
return $default(_that.temperatureC,_that.feelsLikeC,_that.humidity,_that.condition,_that.weatherMain,_that.iconCode,_that.observedAt,_that.latitude,_that.longitude,_that.rainLastHourMm,_that.alerts);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherSnapshot extends WeatherSnapshot {
  const _WeatherSnapshot({required this.temperatureC, required this.feelsLikeC, required this.humidity, required this.condition, required this.weatherMain, required this.iconCode, required this.observedAt, required this.latitude, required this.longitude, this.rainLastHourMm, final  List<WeatherAlert> alerts = const <WeatherAlert>[]}): _alerts = alerts,super._();
  

@override final  double temperatureC;
@override final  double feelsLikeC;
@override final  int humidity;
@override final  String condition;
@override final  String weatherMain;
@override final  String iconCode;
@override final  DateTime observedAt;
@override final  double latitude;
@override final  double longitude;
@override final  double? rainLastHourMm;
 final  List<WeatherAlert> _alerts;
@override@JsonKey() List<WeatherAlert> get alerts {
  if (_alerts is EqualUnmodifiableListView) return _alerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alerts);
}


/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherSnapshotCopyWith<_WeatherSnapshot> get copyWith => __$WeatherSnapshotCopyWithImpl<_WeatherSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherSnapshot&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.feelsLikeC, feelsLikeC) || other.feelsLikeC == feelsLikeC)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.weatherMain, weatherMain) || other.weatherMain == weatherMain)&&(identical(other.iconCode, iconCode) || other.iconCode == iconCode)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.rainLastHourMm, rainLastHourMm) || other.rainLastHourMm == rainLastHourMm)&&const DeepCollectionEquality().equals(other._alerts, _alerts));
}


@override
int get hashCode => Object.hash(runtimeType,temperatureC,feelsLikeC,humidity,condition,weatherMain,iconCode,observedAt,latitude,longitude,rainLastHourMm,const DeepCollectionEquality().hash(_alerts));

@override
String toString() {
  return 'WeatherSnapshot(temperatureC: $temperatureC, feelsLikeC: $feelsLikeC, humidity: $humidity, condition: $condition, weatherMain: $weatherMain, iconCode: $iconCode, observedAt: $observedAt, latitude: $latitude, longitude: $longitude, rainLastHourMm: $rainLastHourMm, alerts: $alerts)';
}


}

/// @nodoc
abstract mixin class _$WeatherSnapshotCopyWith<$Res> implements $WeatherSnapshotCopyWith<$Res> {
  factory _$WeatherSnapshotCopyWith(_WeatherSnapshot value, $Res Function(_WeatherSnapshot) _then) = __$WeatherSnapshotCopyWithImpl;
@override @useResult
$Res call({
 double temperatureC, double feelsLikeC, int humidity, String condition, String weatherMain, String iconCode, DateTime observedAt, double latitude, double longitude, double? rainLastHourMm, List<WeatherAlert> alerts
});




}
/// @nodoc
class __$WeatherSnapshotCopyWithImpl<$Res>
    implements _$WeatherSnapshotCopyWith<$Res> {
  __$WeatherSnapshotCopyWithImpl(this._self, this._then);

  final _WeatherSnapshot _self;
  final $Res Function(_WeatherSnapshot) _then;

/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? temperatureC = null,Object? feelsLikeC = null,Object? humidity = null,Object? condition = null,Object? weatherMain = null,Object? iconCode = null,Object? observedAt = null,Object? latitude = null,Object? longitude = null,Object? rainLastHourMm = freezed,Object? alerts = null,}) {
  return _then(_WeatherSnapshot(
temperatureC: null == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as double,feelsLikeC: null == feelsLikeC ? _self.feelsLikeC : feelsLikeC // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,weatherMain: null == weatherMain ? _self.weatherMain : weatherMain // ignore: cast_nullable_to_non_nullable
as String,iconCode: null == iconCode ? _self.iconCode : iconCode // ignore: cast_nullable_to_non_nullable
as String,observedAt: null == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,rainLastHourMm: freezed == rainLastHourMm ? _self.rainLastHourMm : rainLastHourMm // ignore: cast_nullable_to_non_nullable
as double?,alerts: null == alerts ? _self._alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<WeatherAlert>,
  ));
}


}

// dart format on

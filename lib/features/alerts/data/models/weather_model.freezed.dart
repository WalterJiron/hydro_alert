// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpenWeatherResponse {

 double? get lat; double? get lon; String? get timezone; OpenWeatherCurrent get current; List<OpenWeatherAlert> get alerts;
/// Create a copy of OpenWeatherResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenWeatherResponseCopyWith<OpenWeatherResponse> get copyWith => _$OpenWeatherResponseCopyWithImpl<OpenWeatherResponse>(this as OpenWeatherResponse, _$identity);

  /// Serializes this OpenWeatherResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenWeatherResponse&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other.alerts, alerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon,timezone,current,const DeepCollectionEquality().hash(alerts));

@override
String toString() {
  return 'OpenWeatherResponse(lat: $lat, lon: $lon, timezone: $timezone, current: $current, alerts: $alerts)';
}


}

/// @nodoc
abstract mixin class $OpenWeatherResponseCopyWith<$Res>  {
  factory $OpenWeatherResponseCopyWith(OpenWeatherResponse value, $Res Function(OpenWeatherResponse) _then) = _$OpenWeatherResponseCopyWithImpl;
@useResult
$Res call({
 double? lat, double? lon, String? timezone, OpenWeatherCurrent current, List<OpenWeatherAlert> alerts
});


$OpenWeatherCurrentCopyWith<$Res> get current;

}
/// @nodoc
class _$OpenWeatherResponseCopyWithImpl<$Res>
    implements $OpenWeatherResponseCopyWith<$Res> {
  _$OpenWeatherResponseCopyWithImpl(this._self, this._then);

  final OpenWeatherResponse _self;
  final $Res Function(OpenWeatherResponse) _then;

/// Create a copy of OpenWeatherResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = freezed,Object? lon = freezed,Object? timezone = freezed,Object? current = null,Object? alerts = null,}) {
  return _then(_self.copyWith(
lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as OpenWeatherCurrent,alerts: null == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<OpenWeatherAlert>,
  ));
}
/// Create a copy of OpenWeatherResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenWeatherCurrentCopyWith<$Res> get current {
  
  return $OpenWeatherCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}


/// Adds pattern-matching-related methods to [OpenWeatherResponse].
extension OpenWeatherResponsePatterns on OpenWeatherResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenWeatherResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenWeatherResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenWeatherResponse value)  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenWeatherResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? lat,  double? lon,  String? timezone,  OpenWeatherCurrent current,  List<OpenWeatherAlert> alerts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenWeatherResponse() when $default != null:
return $default(_that.lat,_that.lon,_that.timezone,_that.current,_that.alerts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? lat,  double? lon,  String? timezone,  OpenWeatherCurrent current,  List<OpenWeatherAlert> alerts)  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherResponse():
return $default(_that.lat,_that.lon,_that.timezone,_that.current,_that.alerts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? lat,  double? lon,  String? timezone,  OpenWeatherCurrent current,  List<OpenWeatherAlert> alerts)?  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherResponse() when $default != null:
return $default(_that.lat,_that.lon,_that.timezone,_that.current,_that.alerts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenWeatherResponse implements OpenWeatherResponse {
  const _OpenWeatherResponse({this.lat, this.lon, this.timezone, required this.current, final  List<OpenWeatherAlert> alerts = const <OpenWeatherAlert>[]}): _alerts = alerts;
  factory _OpenWeatherResponse.fromJson(Map<String, dynamic> json) => _$OpenWeatherResponseFromJson(json);

@override final  double? lat;
@override final  double? lon;
@override final  String? timezone;
@override final  OpenWeatherCurrent current;
 final  List<OpenWeatherAlert> _alerts;
@override@JsonKey() List<OpenWeatherAlert> get alerts {
  if (_alerts is EqualUnmodifiableListView) return _alerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alerts);
}


/// Create a copy of OpenWeatherResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenWeatherResponseCopyWith<_OpenWeatherResponse> get copyWith => __$OpenWeatherResponseCopyWithImpl<_OpenWeatherResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenWeatherResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenWeatherResponse&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other._alerts, _alerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon,timezone,current,const DeepCollectionEquality().hash(_alerts));

@override
String toString() {
  return 'OpenWeatherResponse(lat: $lat, lon: $lon, timezone: $timezone, current: $current, alerts: $alerts)';
}


}

/// @nodoc
abstract mixin class _$OpenWeatherResponseCopyWith<$Res> implements $OpenWeatherResponseCopyWith<$Res> {
  factory _$OpenWeatherResponseCopyWith(_OpenWeatherResponse value, $Res Function(_OpenWeatherResponse) _then) = __$OpenWeatherResponseCopyWithImpl;
@override @useResult
$Res call({
 double? lat, double? lon, String? timezone, OpenWeatherCurrent current, List<OpenWeatherAlert> alerts
});


@override $OpenWeatherCurrentCopyWith<$Res> get current;

}
/// @nodoc
class __$OpenWeatherResponseCopyWithImpl<$Res>
    implements _$OpenWeatherResponseCopyWith<$Res> {
  __$OpenWeatherResponseCopyWithImpl(this._self, this._then);

  final _OpenWeatherResponse _self;
  final $Res Function(_OpenWeatherResponse) _then;

/// Create a copy of OpenWeatherResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = freezed,Object? lon = freezed,Object? timezone = freezed,Object? current = null,Object? alerts = null,}) {
  return _then(_OpenWeatherResponse(
lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as OpenWeatherCurrent,alerts: null == alerts ? _self._alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<OpenWeatherAlert>,
  ));
}

/// Create a copy of OpenWeatherResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenWeatherCurrentCopyWith<$Res> get current {
  
  return $OpenWeatherCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}


/// @nodoc
mixin _$OpenWeatherCurrent {

 int? get dt;@JsonKey(fromJson: _asDouble) double? get temp;@JsonKey(name: 'feels_like', fromJson: _asDouble) double? get feelsLike;@JsonKey(fromJson: _asInt) int? get humidity; List<OpenWeatherCondition> get weather; OpenWeatherRain? get rain;
/// Create a copy of OpenWeatherCurrent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenWeatherCurrentCopyWith<OpenWeatherCurrent> get copyWith => _$OpenWeatherCurrentCopyWithImpl<OpenWeatherCurrent>(this as OpenWeatherCurrent, _$identity);

  /// Serializes this OpenWeatherCurrent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenWeatherCurrent&&(identical(other.dt, dt) || other.dt == dt)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&const DeepCollectionEquality().equals(other.weather, weather)&&(identical(other.rain, rain) || other.rain == rain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dt,temp,feelsLike,humidity,const DeepCollectionEquality().hash(weather),rain);

@override
String toString() {
  return 'OpenWeatherCurrent(dt: $dt, temp: $temp, feelsLike: $feelsLike, humidity: $humidity, weather: $weather, rain: $rain)';
}


}

/// @nodoc
abstract mixin class $OpenWeatherCurrentCopyWith<$Res>  {
  factory $OpenWeatherCurrentCopyWith(OpenWeatherCurrent value, $Res Function(OpenWeatherCurrent) _then) = _$OpenWeatherCurrentCopyWithImpl;
@useResult
$Res call({
 int? dt,@JsonKey(fromJson: _asDouble) double? temp,@JsonKey(name: 'feels_like', fromJson: _asDouble) double? feelsLike,@JsonKey(fromJson: _asInt) int? humidity, List<OpenWeatherCondition> weather, OpenWeatherRain? rain
});


$OpenWeatherRainCopyWith<$Res>? get rain;

}
/// @nodoc
class _$OpenWeatherCurrentCopyWithImpl<$Res>
    implements $OpenWeatherCurrentCopyWith<$Res> {
  _$OpenWeatherCurrentCopyWithImpl(this._self, this._then);

  final OpenWeatherCurrent _self;
  final $Res Function(OpenWeatherCurrent) _then;

/// Create a copy of OpenWeatherCurrent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dt = freezed,Object? temp = freezed,Object? feelsLike = freezed,Object? humidity = freezed,Object? weather = null,Object? rain = freezed,}) {
  return _then(_self.copyWith(
dt: freezed == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int?,temp: freezed == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int?,weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as List<OpenWeatherCondition>,rain: freezed == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as OpenWeatherRain?,
  ));
}
/// Create a copy of OpenWeatherCurrent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenWeatherRainCopyWith<$Res>? get rain {
    if (_self.rain == null) {
    return null;
  }

  return $OpenWeatherRainCopyWith<$Res>(_self.rain!, (value) {
    return _then(_self.copyWith(rain: value));
  });
}
}


/// Adds pattern-matching-related methods to [OpenWeatherCurrent].
extension OpenWeatherCurrentPatterns on OpenWeatherCurrent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenWeatherCurrent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenWeatherCurrent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenWeatherCurrent value)  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherCurrent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenWeatherCurrent value)?  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherCurrent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? dt, @JsonKey(fromJson: _asDouble)  double? temp, @JsonKey(name: 'feels_like', fromJson: _asDouble)  double? feelsLike, @JsonKey(fromJson: _asInt)  int? humidity,  List<OpenWeatherCondition> weather,  OpenWeatherRain? rain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenWeatherCurrent() when $default != null:
return $default(_that.dt,_that.temp,_that.feelsLike,_that.humidity,_that.weather,_that.rain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? dt, @JsonKey(fromJson: _asDouble)  double? temp, @JsonKey(name: 'feels_like', fromJson: _asDouble)  double? feelsLike, @JsonKey(fromJson: _asInt)  int? humidity,  List<OpenWeatherCondition> weather,  OpenWeatherRain? rain)  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherCurrent():
return $default(_that.dt,_that.temp,_that.feelsLike,_that.humidity,_that.weather,_that.rain);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? dt, @JsonKey(fromJson: _asDouble)  double? temp, @JsonKey(name: 'feels_like', fromJson: _asDouble)  double? feelsLike, @JsonKey(fromJson: _asInt)  int? humidity,  List<OpenWeatherCondition> weather,  OpenWeatherRain? rain)?  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherCurrent() when $default != null:
return $default(_that.dt,_that.temp,_that.feelsLike,_that.humidity,_that.weather,_that.rain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenWeatherCurrent implements OpenWeatherCurrent {
  const _OpenWeatherCurrent({this.dt, @JsonKey(fromJson: _asDouble) this.temp, @JsonKey(name: 'feels_like', fromJson: _asDouble) this.feelsLike, @JsonKey(fromJson: _asInt) this.humidity, final  List<OpenWeatherCondition> weather = const <OpenWeatherCondition>[], this.rain}): _weather = weather;
  factory _OpenWeatherCurrent.fromJson(Map<String, dynamic> json) => _$OpenWeatherCurrentFromJson(json);

@override final  int? dt;
@override@JsonKey(fromJson: _asDouble) final  double? temp;
@override@JsonKey(name: 'feels_like', fromJson: _asDouble) final  double? feelsLike;
@override@JsonKey(fromJson: _asInt) final  int? humidity;
 final  List<OpenWeatherCondition> _weather;
@override@JsonKey() List<OpenWeatherCondition> get weather {
  if (_weather is EqualUnmodifiableListView) return _weather;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weather);
}

@override final  OpenWeatherRain? rain;

/// Create a copy of OpenWeatherCurrent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenWeatherCurrentCopyWith<_OpenWeatherCurrent> get copyWith => __$OpenWeatherCurrentCopyWithImpl<_OpenWeatherCurrent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenWeatherCurrentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenWeatherCurrent&&(identical(other.dt, dt) || other.dt == dt)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&const DeepCollectionEquality().equals(other._weather, _weather)&&(identical(other.rain, rain) || other.rain == rain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dt,temp,feelsLike,humidity,const DeepCollectionEquality().hash(_weather),rain);

@override
String toString() {
  return 'OpenWeatherCurrent(dt: $dt, temp: $temp, feelsLike: $feelsLike, humidity: $humidity, weather: $weather, rain: $rain)';
}


}

/// @nodoc
abstract mixin class _$OpenWeatherCurrentCopyWith<$Res> implements $OpenWeatherCurrentCopyWith<$Res> {
  factory _$OpenWeatherCurrentCopyWith(_OpenWeatherCurrent value, $Res Function(_OpenWeatherCurrent) _then) = __$OpenWeatherCurrentCopyWithImpl;
@override @useResult
$Res call({
 int? dt,@JsonKey(fromJson: _asDouble) double? temp,@JsonKey(name: 'feels_like', fromJson: _asDouble) double? feelsLike,@JsonKey(fromJson: _asInt) int? humidity, List<OpenWeatherCondition> weather, OpenWeatherRain? rain
});


@override $OpenWeatherRainCopyWith<$Res>? get rain;

}
/// @nodoc
class __$OpenWeatherCurrentCopyWithImpl<$Res>
    implements _$OpenWeatherCurrentCopyWith<$Res> {
  __$OpenWeatherCurrentCopyWithImpl(this._self, this._then);

  final _OpenWeatherCurrent _self;
  final $Res Function(_OpenWeatherCurrent) _then;

/// Create a copy of OpenWeatherCurrent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dt = freezed,Object? temp = freezed,Object? feelsLike = freezed,Object? humidity = freezed,Object? weather = null,Object? rain = freezed,}) {
  return _then(_OpenWeatherCurrent(
dt: freezed == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int?,temp: freezed == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int?,weather: null == weather ? _self._weather : weather // ignore: cast_nullable_to_non_nullable
as List<OpenWeatherCondition>,rain: freezed == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as OpenWeatherRain?,
  ));
}

/// Create a copy of OpenWeatherCurrent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenWeatherRainCopyWith<$Res>? get rain {
    if (_self.rain == null) {
    return null;
  }

  return $OpenWeatherRainCopyWith<$Res>(_self.rain!, (value) {
    return _then(_self.copyWith(rain: value));
  });
}
}


/// @nodoc
mixin _$OpenWeatherCondition {

 int? get id; String? get main; String? get description; String? get icon;
/// Create a copy of OpenWeatherCondition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenWeatherConditionCopyWith<OpenWeatherCondition> get copyWith => _$OpenWeatherConditionCopyWithImpl<OpenWeatherCondition>(this as OpenWeatherCondition, _$identity);

  /// Serializes this OpenWeatherCondition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenWeatherCondition&&(identical(other.id, id) || other.id == id)&&(identical(other.main, main) || other.main == main)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,main,description,icon);

@override
String toString() {
  return 'OpenWeatherCondition(id: $id, main: $main, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $OpenWeatherConditionCopyWith<$Res>  {
  factory $OpenWeatherConditionCopyWith(OpenWeatherCondition value, $Res Function(OpenWeatherCondition) _then) = _$OpenWeatherConditionCopyWithImpl;
@useResult
$Res call({
 int? id, String? main, String? description, String? icon
});




}
/// @nodoc
class _$OpenWeatherConditionCopyWithImpl<$Res>
    implements $OpenWeatherConditionCopyWith<$Res> {
  _$OpenWeatherConditionCopyWithImpl(this._self, this._then);

  final OpenWeatherCondition _self;
  final $Res Function(OpenWeatherCondition) _then;

/// Create a copy of OpenWeatherCondition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? main = freezed,Object? description = freezed,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,main: freezed == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenWeatherCondition].
extension OpenWeatherConditionPatterns on OpenWeatherCondition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenWeatherCondition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenWeatherCondition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenWeatherCondition value)  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherCondition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenWeatherCondition value)?  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherCondition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? main,  String? description,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenWeatherCondition() when $default != null:
return $default(_that.id,_that.main,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? main,  String? description,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherCondition():
return $default(_that.id,_that.main,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? main,  String? description,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherCondition() when $default != null:
return $default(_that.id,_that.main,_that.description,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenWeatherCondition implements OpenWeatherCondition {
  const _OpenWeatherCondition({this.id, this.main, this.description, this.icon});
  factory _OpenWeatherCondition.fromJson(Map<String, dynamic> json) => _$OpenWeatherConditionFromJson(json);

@override final  int? id;
@override final  String? main;
@override final  String? description;
@override final  String? icon;

/// Create a copy of OpenWeatherCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenWeatherConditionCopyWith<_OpenWeatherCondition> get copyWith => __$OpenWeatherConditionCopyWithImpl<_OpenWeatherCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenWeatherConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenWeatherCondition&&(identical(other.id, id) || other.id == id)&&(identical(other.main, main) || other.main == main)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,main,description,icon);

@override
String toString() {
  return 'OpenWeatherCondition(id: $id, main: $main, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$OpenWeatherConditionCopyWith<$Res> implements $OpenWeatherConditionCopyWith<$Res> {
  factory _$OpenWeatherConditionCopyWith(_OpenWeatherCondition value, $Res Function(_OpenWeatherCondition) _then) = __$OpenWeatherConditionCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? main, String? description, String? icon
});




}
/// @nodoc
class __$OpenWeatherConditionCopyWithImpl<$Res>
    implements _$OpenWeatherConditionCopyWith<$Res> {
  __$OpenWeatherConditionCopyWithImpl(this._self, this._then);

  final _OpenWeatherCondition _self;
  final $Res Function(_OpenWeatherCondition) _then;

/// Create a copy of OpenWeatherCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? main = freezed,Object? description = freezed,Object? icon = freezed,}) {
  return _then(_OpenWeatherCondition(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,main: freezed == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OpenWeatherRain {

@JsonKey(name: '1h', fromJson: _asDouble) double? get oneHour;@JsonKey(name: '3h', fromJson: _asDouble) double? get threeHours;
/// Create a copy of OpenWeatherRain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenWeatherRainCopyWith<OpenWeatherRain> get copyWith => _$OpenWeatherRainCopyWithImpl<OpenWeatherRain>(this as OpenWeatherRain, _$identity);

  /// Serializes this OpenWeatherRain to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenWeatherRain&&(identical(other.oneHour, oneHour) || other.oneHour == oneHour)&&(identical(other.threeHours, threeHours) || other.threeHours == threeHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oneHour,threeHours);

@override
String toString() {
  return 'OpenWeatherRain(oneHour: $oneHour, threeHours: $threeHours)';
}


}

/// @nodoc
abstract mixin class $OpenWeatherRainCopyWith<$Res>  {
  factory $OpenWeatherRainCopyWith(OpenWeatherRain value, $Res Function(OpenWeatherRain) _then) = _$OpenWeatherRainCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '1h', fromJson: _asDouble) double? oneHour,@JsonKey(name: '3h', fromJson: _asDouble) double? threeHours
});




}
/// @nodoc
class _$OpenWeatherRainCopyWithImpl<$Res>
    implements $OpenWeatherRainCopyWith<$Res> {
  _$OpenWeatherRainCopyWithImpl(this._self, this._then);

  final OpenWeatherRain _self;
  final $Res Function(OpenWeatherRain) _then;

/// Create a copy of OpenWeatherRain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oneHour = freezed,Object? threeHours = freezed,}) {
  return _then(_self.copyWith(
oneHour: freezed == oneHour ? _self.oneHour : oneHour // ignore: cast_nullable_to_non_nullable
as double?,threeHours: freezed == threeHours ? _self.threeHours : threeHours // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenWeatherRain].
extension OpenWeatherRainPatterns on OpenWeatherRain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenWeatherRain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenWeatherRain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenWeatherRain value)  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherRain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenWeatherRain value)?  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherRain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '1h', fromJson: _asDouble)  double? oneHour, @JsonKey(name: '3h', fromJson: _asDouble)  double? threeHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenWeatherRain() when $default != null:
return $default(_that.oneHour,_that.threeHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '1h', fromJson: _asDouble)  double? oneHour, @JsonKey(name: '3h', fromJson: _asDouble)  double? threeHours)  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherRain():
return $default(_that.oneHour,_that.threeHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '1h', fromJson: _asDouble)  double? oneHour, @JsonKey(name: '3h', fromJson: _asDouble)  double? threeHours)?  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherRain() when $default != null:
return $default(_that.oneHour,_that.threeHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenWeatherRain implements OpenWeatherRain {
  const _OpenWeatherRain({@JsonKey(name: '1h', fromJson: _asDouble) this.oneHour, @JsonKey(name: '3h', fromJson: _asDouble) this.threeHours});
  factory _OpenWeatherRain.fromJson(Map<String, dynamic> json) => _$OpenWeatherRainFromJson(json);

@override@JsonKey(name: '1h', fromJson: _asDouble) final  double? oneHour;
@override@JsonKey(name: '3h', fromJson: _asDouble) final  double? threeHours;

/// Create a copy of OpenWeatherRain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenWeatherRainCopyWith<_OpenWeatherRain> get copyWith => __$OpenWeatherRainCopyWithImpl<_OpenWeatherRain>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenWeatherRainToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenWeatherRain&&(identical(other.oneHour, oneHour) || other.oneHour == oneHour)&&(identical(other.threeHours, threeHours) || other.threeHours == threeHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oneHour,threeHours);

@override
String toString() {
  return 'OpenWeatherRain(oneHour: $oneHour, threeHours: $threeHours)';
}


}

/// @nodoc
abstract mixin class _$OpenWeatherRainCopyWith<$Res> implements $OpenWeatherRainCopyWith<$Res> {
  factory _$OpenWeatherRainCopyWith(_OpenWeatherRain value, $Res Function(_OpenWeatherRain) _then) = __$OpenWeatherRainCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '1h', fromJson: _asDouble) double? oneHour,@JsonKey(name: '3h', fromJson: _asDouble) double? threeHours
});




}
/// @nodoc
class __$OpenWeatherRainCopyWithImpl<$Res>
    implements _$OpenWeatherRainCopyWith<$Res> {
  __$OpenWeatherRainCopyWithImpl(this._self, this._then);

  final _OpenWeatherRain _self;
  final $Res Function(_OpenWeatherRain) _then;

/// Create a copy of OpenWeatherRain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oneHour = freezed,Object? threeHours = freezed,}) {
  return _then(_OpenWeatherRain(
oneHour: freezed == oneHour ? _self.oneHour : oneHour // ignore: cast_nullable_to_non_nullable
as double?,threeHours: freezed == threeHours ? _self.threeHours : threeHours // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$OpenWeatherAlert {

@JsonKey(name: 'sender_name') String? get senderName; String? get event; int? get start; int? get end; String? get description; List<String> get tags;
/// Create a copy of OpenWeatherAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenWeatherAlertCopyWith<OpenWeatherAlert> get copyWith => _$OpenWeatherAlertCopyWithImpl<OpenWeatherAlert>(this as OpenWeatherAlert, _$identity);

  /// Serializes this OpenWeatherAlert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenWeatherAlert&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.event, event) || other.event == event)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,senderName,event,start,end,description,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'OpenWeatherAlert(senderName: $senderName, event: $event, start: $start, end: $end, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $OpenWeatherAlertCopyWith<$Res>  {
  factory $OpenWeatherAlertCopyWith(OpenWeatherAlert value, $Res Function(OpenWeatherAlert) _then) = _$OpenWeatherAlertCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'sender_name') String? senderName, String? event, int? start, int? end, String? description, List<String> tags
});




}
/// @nodoc
class _$OpenWeatherAlertCopyWithImpl<$Res>
    implements $OpenWeatherAlertCopyWith<$Res> {
  _$OpenWeatherAlertCopyWithImpl(this._self, this._then);

  final OpenWeatherAlert _self;
  final $Res Function(OpenWeatherAlert) _then;

/// Create a copy of OpenWeatherAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? senderName = freezed,Object? event = freezed,Object? start = freezed,Object? end = freezed,Object? description = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String?,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenWeatherAlert].
extension OpenWeatherAlertPatterns on OpenWeatherAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenWeatherAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenWeatherAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenWeatherAlert value)  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenWeatherAlert value)?  $default,){
final _that = this;
switch (_that) {
case _OpenWeatherAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'sender_name')  String? senderName,  String? event,  int? start,  int? end,  String? description,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenWeatherAlert() when $default != null:
return $default(_that.senderName,_that.event,_that.start,_that.end,_that.description,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'sender_name')  String? senderName,  String? event,  int? start,  int? end,  String? description,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherAlert():
return $default(_that.senderName,_that.event,_that.start,_that.end,_that.description,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'sender_name')  String? senderName,  String? event,  int? start,  int? end,  String? description,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _OpenWeatherAlert() when $default != null:
return $default(_that.senderName,_that.event,_that.start,_that.end,_that.description,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenWeatherAlert implements OpenWeatherAlert {
  const _OpenWeatherAlert({@JsonKey(name: 'sender_name') this.senderName, this.event, this.start, this.end, this.description, final  List<String> tags = const <String>[]}): _tags = tags;
  factory _OpenWeatherAlert.fromJson(Map<String, dynamic> json) => _$OpenWeatherAlertFromJson(json);

@override@JsonKey(name: 'sender_name') final  String? senderName;
@override final  String? event;
@override final  int? start;
@override final  int? end;
@override final  String? description;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of OpenWeatherAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenWeatherAlertCopyWith<_OpenWeatherAlert> get copyWith => __$OpenWeatherAlertCopyWithImpl<_OpenWeatherAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenWeatherAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenWeatherAlert&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.event, event) || other.event == event)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,senderName,event,start,end,description,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'OpenWeatherAlert(senderName: $senderName, event: $event, start: $start, end: $end, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$OpenWeatherAlertCopyWith<$Res> implements $OpenWeatherAlertCopyWith<$Res> {
  factory _$OpenWeatherAlertCopyWith(_OpenWeatherAlert value, $Res Function(_OpenWeatherAlert) _then) = __$OpenWeatherAlertCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'sender_name') String? senderName, String? event, int? start, int? end, String? description, List<String> tags
});




}
/// @nodoc
class __$OpenWeatherAlertCopyWithImpl<$Res>
    implements _$OpenWeatherAlertCopyWith<$Res> {
  __$OpenWeatherAlertCopyWithImpl(this._self, this._then);

  final _OpenWeatherAlert _self;
  final $Res Function(_OpenWeatherAlert) _then;

/// Create a copy of OpenWeatherAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? senderName = freezed,Object? event = freezed,Object? start = freezed,Object? end = freezed,Object? description = freezed,Object? tags = null,}) {
  return _then(_OpenWeatherAlert(
senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String?,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weatherapi_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherApiResponse {

 WeatherApiLocation? get location; WeatherApiCurrent get current; WeatherApiAlerts? get alerts;
/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherApiResponseCopyWith<WeatherApiResponse> get copyWith => _$WeatherApiResponseCopyWithImpl<WeatherApiResponse>(this as WeatherApiResponse, _$identity);

  /// Serializes this WeatherApiResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherApiResponse&&(identical(other.location, location) || other.location == location)&&(identical(other.current, current) || other.current == current)&&(identical(other.alerts, alerts) || other.alerts == alerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,current,alerts);

@override
String toString() {
  return 'WeatherApiResponse(location: $location, current: $current, alerts: $alerts)';
}


}

/// @nodoc
abstract mixin class $WeatherApiResponseCopyWith<$Res>  {
  factory $WeatherApiResponseCopyWith(WeatherApiResponse value, $Res Function(WeatherApiResponse) _then) = _$WeatherApiResponseCopyWithImpl;
@useResult
$Res call({
 WeatherApiLocation? location, WeatherApiCurrent current, WeatherApiAlerts? alerts
});


$WeatherApiLocationCopyWith<$Res>? get location;$WeatherApiCurrentCopyWith<$Res> get current;$WeatherApiAlertsCopyWith<$Res>? get alerts;

}
/// @nodoc
class _$WeatherApiResponseCopyWithImpl<$Res>
    implements $WeatherApiResponseCopyWith<$Res> {
  _$WeatherApiResponseCopyWithImpl(this._self, this._then);

  final WeatherApiResponse _self;
  final $Res Function(WeatherApiResponse) _then;

/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = freezed,Object? current = null,Object? alerts = freezed,}) {
  return _then(_self.copyWith(
location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as WeatherApiLocation?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as WeatherApiCurrent,alerts: freezed == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as WeatherApiAlerts?,
  ));
}
/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $WeatherApiLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiCurrentCopyWith<$Res> get current {
  
  return $WeatherApiCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiAlertsCopyWith<$Res>? get alerts {
    if (_self.alerts == null) {
    return null;
  }

  return $WeatherApiAlertsCopyWith<$Res>(_self.alerts!, (value) {
    return _then(_self.copyWith(alerts: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeatherApiResponse].
extension WeatherApiResponsePatterns on WeatherApiResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherApiResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherApiResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherApiResponse value)  $default,){
final _that = this;
switch (_that) {
case _WeatherApiResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherApiResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherApiResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WeatherApiLocation? location,  WeatherApiCurrent current,  WeatherApiAlerts? alerts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherApiResponse() when $default != null:
return $default(_that.location,_that.current,_that.alerts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WeatherApiLocation? location,  WeatherApiCurrent current,  WeatherApiAlerts? alerts)  $default,) {final _that = this;
switch (_that) {
case _WeatherApiResponse():
return $default(_that.location,_that.current,_that.alerts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WeatherApiLocation? location,  WeatherApiCurrent current,  WeatherApiAlerts? alerts)?  $default,) {final _that = this;
switch (_that) {
case _WeatherApiResponse() when $default != null:
return $default(_that.location,_that.current,_that.alerts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherApiResponse implements WeatherApiResponse {
  const _WeatherApiResponse({this.location, required this.current, this.alerts});
  factory _WeatherApiResponse.fromJson(Map<String, dynamic> json) => _$WeatherApiResponseFromJson(json);

@override final  WeatherApiLocation? location;
@override final  WeatherApiCurrent current;
@override final  WeatherApiAlerts? alerts;

/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherApiResponseCopyWith<_WeatherApiResponse> get copyWith => __$WeatherApiResponseCopyWithImpl<_WeatherApiResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherApiResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherApiResponse&&(identical(other.location, location) || other.location == location)&&(identical(other.current, current) || other.current == current)&&(identical(other.alerts, alerts) || other.alerts == alerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,current,alerts);

@override
String toString() {
  return 'WeatherApiResponse(location: $location, current: $current, alerts: $alerts)';
}


}

/// @nodoc
abstract mixin class _$WeatherApiResponseCopyWith<$Res> implements $WeatherApiResponseCopyWith<$Res> {
  factory _$WeatherApiResponseCopyWith(_WeatherApiResponse value, $Res Function(_WeatherApiResponse) _then) = __$WeatherApiResponseCopyWithImpl;
@override @useResult
$Res call({
 WeatherApiLocation? location, WeatherApiCurrent current, WeatherApiAlerts? alerts
});


@override $WeatherApiLocationCopyWith<$Res>? get location;@override $WeatherApiCurrentCopyWith<$Res> get current;@override $WeatherApiAlertsCopyWith<$Res>? get alerts;

}
/// @nodoc
class __$WeatherApiResponseCopyWithImpl<$Res>
    implements _$WeatherApiResponseCopyWith<$Res> {
  __$WeatherApiResponseCopyWithImpl(this._self, this._then);

  final _WeatherApiResponse _self;
  final $Res Function(_WeatherApiResponse) _then;

/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = freezed,Object? current = null,Object? alerts = freezed,}) {
  return _then(_WeatherApiResponse(
location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as WeatherApiLocation?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as WeatherApiCurrent,alerts: freezed == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as WeatherApiAlerts?,
  ));
}

/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $WeatherApiLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiCurrentCopyWith<$Res> get current {
  
  return $WeatherApiCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of WeatherApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiAlertsCopyWith<$Res>? get alerts {
    if (_self.alerts == null) {
    return null;
  }

  return $WeatherApiAlertsCopyWith<$Res>(_self.alerts!, (value) {
    return _then(_self.copyWith(alerts: value));
  });
}
}


/// @nodoc
mixin _$WeatherApiLocation {

 String? get name;@JsonKey(fromJson: _asDouble) double? get lat;@JsonKey(fromJson: _asDouble) double? get lon;@JsonKey(name: 'tz_id') String? get timezoneId;
/// Create a copy of WeatherApiLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherApiLocationCopyWith<WeatherApiLocation> get copyWith => _$WeatherApiLocationCopyWithImpl<WeatherApiLocation>(this as WeatherApiLocation, _$identity);

  /// Serializes this WeatherApiLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherApiLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.timezoneId, timezoneId) || other.timezoneId == timezoneId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lat,lon,timezoneId);

@override
String toString() {
  return 'WeatherApiLocation(name: $name, lat: $lat, lon: $lon, timezoneId: $timezoneId)';
}


}

/// @nodoc
abstract mixin class $WeatherApiLocationCopyWith<$Res>  {
  factory $WeatherApiLocationCopyWith(WeatherApiLocation value, $Res Function(WeatherApiLocation) _then) = _$WeatherApiLocationCopyWithImpl;
@useResult
$Res call({
 String? name,@JsonKey(fromJson: _asDouble) double? lat,@JsonKey(fromJson: _asDouble) double? lon,@JsonKey(name: 'tz_id') String? timezoneId
});




}
/// @nodoc
class _$WeatherApiLocationCopyWithImpl<$Res>
    implements $WeatherApiLocationCopyWith<$Res> {
  _$WeatherApiLocationCopyWithImpl(this._self, this._then);

  final WeatherApiLocation _self;
  final $Res Function(WeatherApiLocation) _then;

/// Create a copy of WeatherApiLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? lat = freezed,Object? lon = freezed,Object? timezoneId = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,timezoneId: freezed == timezoneId ? _self.timezoneId : timezoneId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherApiLocation].
extension WeatherApiLocationPatterns on WeatherApiLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherApiLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherApiLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherApiLocation value)  $default,){
final _that = this;
switch (_that) {
case _WeatherApiLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherApiLocation value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherApiLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name, @JsonKey(fromJson: _asDouble)  double? lat, @JsonKey(fromJson: _asDouble)  double? lon, @JsonKey(name: 'tz_id')  String? timezoneId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherApiLocation() when $default != null:
return $default(_that.name,_that.lat,_that.lon,_that.timezoneId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name, @JsonKey(fromJson: _asDouble)  double? lat, @JsonKey(fromJson: _asDouble)  double? lon, @JsonKey(name: 'tz_id')  String? timezoneId)  $default,) {final _that = this;
switch (_that) {
case _WeatherApiLocation():
return $default(_that.name,_that.lat,_that.lon,_that.timezoneId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name, @JsonKey(fromJson: _asDouble)  double? lat, @JsonKey(fromJson: _asDouble)  double? lon, @JsonKey(name: 'tz_id')  String? timezoneId)?  $default,) {final _that = this;
switch (_that) {
case _WeatherApiLocation() when $default != null:
return $default(_that.name,_that.lat,_that.lon,_that.timezoneId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherApiLocation implements WeatherApiLocation {
  const _WeatherApiLocation({this.name, @JsonKey(fromJson: _asDouble) this.lat, @JsonKey(fromJson: _asDouble) this.lon, @JsonKey(name: 'tz_id') this.timezoneId});
  factory _WeatherApiLocation.fromJson(Map<String, dynamic> json) => _$WeatherApiLocationFromJson(json);

@override final  String? name;
@override@JsonKey(fromJson: _asDouble) final  double? lat;
@override@JsonKey(fromJson: _asDouble) final  double? lon;
@override@JsonKey(name: 'tz_id') final  String? timezoneId;

/// Create a copy of WeatherApiLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherApiLocationCopyWith<_WeatherApiLocation> get copyWith => __$WeatherApiLocationCopyWithImpl<_WeatherApiLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherApiLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherApiLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.timezoneId, timezoneId) || other.timezoneId == timezoneId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lat,lon,timezoneId);

@override
String toString() {
  return 'WeatherApiLocation(name: $name, lat: $lat, lon: $lon, timezoneId: $timezoneId)';
}


}

/// @nodoc
abstract mixin class _$WeatherApiLocationCopyWith<$Res> implements $WeatherApiLocationCopyWith<$Res> {
  factory _$WeatherApiLocationCopyWith(_WeatherApiLocation value, $Res Function(_WeatherApiLocation) _then) = __$WeatherApiLocationCopyWithImpl;
@override @useResult
$Res call({
 String? name,@JsonKey(fromJson: _asDouble) double? lat,@JsonKey(fromJson: _asDouble) double? lon,@JsonKey(name: 'tz_id') String? timezoneId
});




}
/// @nodoc
class __$WeatherApiLocationCopyWithImpl<$Res>
    implements _$WeatherApiLocationCopyWith<$Res> {
  __$WeatherApiLocationCopyWithImpl(this._self, this._then);

  final _WeatherApiLocation _self;
  final $Res Function(_WeatherApiLocation) _then;

/// Create a copy of WeatherApiLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? lat = freezed,Object? lon = freezed,Object? timezoneId = freezed,}) {
  return _then(_WeatherApiLocation(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,timezoneId: freezed == timezoneId ? _self.timezoneId : timezoneId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WeatherApiCurrent {

@JsonKey(name: 'last_updated_epoch', fromJson: _asInt) int? get lastUpdatedEpoch;@JsonKey(name: 'temp_c', fromJson: _asDouble) double? get temperatureC;@JsonKey(name: 'feelslike_c', fromJson: _asDouble) double? get feelsLikeC;@JsonKey(fromJson: _asInt) int? get humidity;@JsonKey(name: 'is_day', fromJson: _asInt) int? get isDay;@JsonKey(name: 'precip_mm', fromJson: _asDouble) double? get precipitationMm; WeatherApiCondition? get condition;
/// Create a copy of WeatherApiCurrent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherApiCurrentCopyWith<WeatherApiCurrent> get copyWith => _$WeatherApiCurrentCopyWithImpl<WeatherApiCurrent>(this as WeatherApiCurrent, _$identity);

  /// Serializes this WeatherApiCurrent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherApiCurrent&&(identical(other.lastUpdatedEpoch, lastUpdatedEpoch) || other.lastUpdatedEpoch == lastUpdatedEpoch)&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.feelsLikeC, feelsLikeC) || other.feelsLikeC == feelsLikeC)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.precipitationMm, precipitationMm) || other.precipitationMm == precipitationMm)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastUpdatedEpoch,temperatureC,feelsLikeC,humidity,isDay,precipitationMm,condition);

@override
String toString() {
  return 'WeatherApiCurrent(lastUpdatedEpoch: $lastUpdatedEpoch, temperatureC: $temperatureC, feelsLikeC: $feelsLikeC, humidity: $humidity, isDay: $isDay, precipitationMm: $precipitationMm, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $WeatherApiCurrentCopyWith<$Res>  {
  factory $WeatherApiCurrentCopyWith(WeatherApiCurrent value, $Res Function(WeatherApiCurrent) _then) = _$WeatherApiCurrentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'last_updated_epoch', fromJson: _asInt) int? lastUpdatedEpoch,@JsonKey(name: 'temp_c', fromJson: _asDouble) double? temperatureC,@JsonKey(name: 'feelslike_c', fromJson: _asDouble) double? feelsLikeC,@JsonKey(fromJson: _asInt) int? humidity,@JsonKey(name: 'is_day', fromJson: _asInt) int? isDay,@JsonKey(name: 'precip_mm', fromJson: _asDouble) double? precipitationMm, WeatherApiCondition? condition
});


$WeatherApiConditionCopyWith<$Res>? get condition;

}
/// @nodoc
class _$WeatherApiCurrentCopyWithImpl<$Res>
    implements $WeatherApiCurrentCopyWith<$Res> {
  _$WeatherApiCurrentCopyWithImpl(this._self, this._then);

  final WeatherApiCurrent _self;
  final $Res Function(WeatherApiCurrent) _then;

/// Create a copy of WeatherApiCurrent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastUpdatedEpoch = freezed,Object? temperatureC = freezed,Object? feelsLikeC = freezed,Object? humidity = freezed,Object? isDay = freezed,Object? precipitationMm = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
lastUpdatedEpoch: freezed == lastUpdatedEpoch ? _self.lastUpdatedEpoch : lastUpdatedEpoch // ignore: cast_nullable_to_non_nullable
as int?,temperatureC: freezed == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as double?,feelsLikeC: freezed == feelsLikeC ? _self.feelsLikeC : feelsLikeC // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int?,isDay: freezed == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as int?,precipitationMm: freezed == precipitationMm ? _self.precipitationMm : precipitationMm // ignore: cast_nullable_to_non_nullable
as double?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherApiCondition?,
  ));
}
/// Create a copy of WeatherApiCurrent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiConditionCopyWith<$Res>? get condition {
    if (_self.condition == null) {
    return null;
  }

  return $WeatherApiConditionCopyWith<$Res>(_self.condition!, (value) {
    return _then(_self.copyWith(condition: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeatherApiCurrent].
extension WeatherApiCurrentPatterns on WeatherApiCurrent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherApiCurrent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherApiCurrent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherApiCurrent value)  $default,){
final _that = this;
switch (_that) {
case _WeatherApiCurrent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherApiCurrent value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherApiCurrent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'last_updated_epoch', fromJson: _asInt)  int? lastUpdatedEpoch, @JsonKey(name: 'temp_c', fromJson: _asDouble)  double? temperatureC, @JsonKey(name: 'feelslike_c', fromJson: _asDouble)  double? feelsLikeC, @JsonKey(fromJson: _asInt)  int? humidity, @JsonKey(name: 'is_day', fromJson: _asInt)  int? isDay, @JsonKey(name: 'precip_mm', fromJson: _asDouble)  double? precipitationMm,  WeatherApiCondition? condition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherApiCurrent() when $default != null:
return $default(_that.lastUpdatedEpoch,_that.temperatureC,_that.feelsLikeC,_that.humidity,_that.isDay,_that.precipitationMm,_that.condition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'last_updated_epoch', fromJson: _asInt)  int? lastUpdatedEpoch, @JsonKey(name: 'temp_c', fromJson: _asDouble)  double? temperatureC, @JsonKey(name: 'feelslike_c', fromJson: _asDouble)  double? feelsLikeC, @JsonKey(fromJson: _asInt)  int? humidity, @JsonKey(name: 'is_day', fromJson: _asInt)  int? isDay, @JsonKey(name: 'precip_mm', fromJson: _asDouble)  double? precipitationMm,  WeatherApiCondition? condition)  $default,) {final _that = this;
switch (_that) {
case _WeatherApiCurrent():
return $default(_that.lastUpdatedEpoch,_that.temperatureC,_that.feelsLikeC,_that.humidity,_that.isDay,_that.precipitationMm,_that.condition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'last_updated_epoch', fromJson: _asInt)  int? lastUpdatedEpoch, @JsonKey(name: 'temp_c', fromJson: _asDouble)  double? temperatureC, @JsonKey(name: 'feelslike_c', fromJson: _asDouble)  double? feelsLikeC, @JsonKey(fromJson: _asInt)  int? humidity, @JsonKey(name: 'is_day', fromJson: _asInt)  int? isDay, @JsonKey(name: 'precip_mm', fromJson: _asDouble)  double? precipitationMm,  WeatherApiCondition? condition)?  $default,) {final _that = this;
switch (_that) {
case _WeatherApiCurrent() when $default != null:
return $default(_that.lastUpdatedEpoch,_that.temperatureC,_that.feelsLikeC,_that.humidity,_that.isDay,_that.precipitationMm,_that.condition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherApiCurrent implements WeatherApiCurrent {
  const _WeatherApiCurrent({@JsonKey(name: 'last_updated_epoch', fromJson: _asInt) this.lastUpdatedEpoch, @JsonKey(name: 'temp_c', fromJson: _asDouble) this.temperatureC, @JsonKey(name: 'feelslike_c', fromJson: _asDouble) this.feelsLikeC, @JsonKey(fromJson: _asInt) this.humidity, @JsonKey(name: 'is_day', fromJson: _asInt) this.isDay, @JsonKey(name: 'precip_mm', fromJson: _asDouble) this.precipitationMm, this.condition});
  factory _WeatherApiCurrent.fromJson(Map<String, dynamic> json) => _$WeatherApiCurrentFromJson(json);

@override@JsonKey(name: 'last_updated_epoch', fromJson: _asInt) final  int? lastUpdatedEpoch;
@override@JsonKey(name: 'temp_c', fromJson: _asDouble) final  double? temperatureC;
@override@JsonKey(name: 'feelslike_c', fromJson: _asDouble) final  double? feelsLikeC;
@override@JsonKey(fromJson: _asInt) final  int? humidity;
@override@JsonKey(name: 'is_day', fromJson: _asInt) final  int? isDay;
@override@JsonKey(name: 'precip_mm', fromJson: _asDouble) final  double? precipitationMm;
@override final  WeatherApiCondition? condition;

/// Create a copy of WeatherApiCurrent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherApiCurrentCopyWith<_WeatherApiCurrent> get copyWith => __$WeatherApiCurrentCopyWithImpl<_WeatherApiCurrent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherApiCurrentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherApiCurrent&&(identical(other.lastUpdatedEpoch, lastUpdatedEpoch) || other.lastUpdatedEpoch == lastUpdatedEpoch)&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.feelsLikeC, feelsLikeC) || other.feelsLikeC == feelsLikeC)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.precipitationMm, precipitationMm) || other.precipitationMm == precipitationMm)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastUpdatedEpoch,temperatureC,feelsLikeC,humidity,isDay,precipitationMm,condition);

@override
String toString() {
  return 'WeatherApiCurrent(lastUpdatedEpoch: $lastUpdatedEpoch, temperatureC: $temperatureC, feelsLikeC: $feelsLikeC, humidity: $humidity, isDay: $isDay, precipitationMm: $precipitationMm, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$WeatherApiCurrentCopyWith<$Res> implements $WeatherApiCurrentCopyWith<$Res> {
  factory _$WeatherApiCurrentCopyWith(_WeatherApiCurrent value, $Res Function(_WeatherApiCurrent) _then) = __$WeatherApiCurrentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'last_updated_epoch', fromJson: _asInt) int? lastUpdatedEpoch,@JsonKey(name: 'temp_c', fromJson: _asDouble) double? temperatureC,@JsonKey(name: 'feelslike_c', fromJson: _asDouble) double? feelsLikeC,@JsonKey(fromJson: _asInt) int? humidity,@JsonKey(name: 'is_day', fromJson: _asInt) int? isDay,@JsonKey(name: 'precip_mm', fromJson: _asDouble) double? precipitationMm, WeatherApiCondition? condition
});


@override $WeatherApiConditionCopyWith<$Res>? get condition;

}
/// @nodoc
class __$WeatherApiCurrentCopyWithImpl<$Res>
    implements _$WeatherApiCurrentCopyWith<$Res> {
  __$WeatherApiCurrentCopyWithImpl(this._self, this._then);

  final _WeatherApiCurrent _self;
  final $Res Function(_WeatherApiCurrent) _then;

/// Create a copy of WeatherApiCurrent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastUpdatedEpoch = freezed,Object? temperatureC = freezed,Object? feelsLikeC = freezed,Object? humidity = freezed,Object? isDay = freezed,Object? precipitationMm = freezed,Object? condition = freezed,}) {
  return _then(_WeatherApiCurrent(
lastUpdatedEpoch: freezed == lastUpdatedEpoch ? _self.lastUpdatedEpoch : lastUpdatedEpoch // ignore: cast_nullable_to_non_nullable
as int?,temperatureC: freezed == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as double?,feelsLikeC: freezed == feelsLikeC ? _self.feelsLikeC : feelsLikeC // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int?,isDay: freezed == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as int?,precipitationMm: freezed == precipitationMm ? _self.precipitationMm : precipitationMm // ignore: cast_nullable_to_non_nullable
as double?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherApiCondition?,
  ));
}

/// Create a copy of WeatherApiCurrent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherApiConditionCopyWith<$Res>? get condition {
    if (_self.condition == null) {
    return null;
  }

  return $WeatherApiConditionCopyWith<$Res>(_self.condition!, (value) {
    return _then(_self.copyWith(condition: value));
  });
}
}


/// @nodoc
mixin _$WeatherApiCondition {

 String? get text; String? get icon;@JsonKey(fromJson: _asInt) int? get code;
/// Create a copy of WeatherApiCondition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherApiConditionCopyWith<WeatherApiCondition> get copyWith => _$WeatherApiConditionCopyWithImpl<WeatherApiCondition>(this as WeatherApiCondition, _$identity);

  /// Serializes this WeatherApiCondition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherApiCondition&&(identical(other.text, text) || other.text == text)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,icon,code);

@override
String toString() {
  return 'WeatherApiCondition(text: $text, icon: $icon, code: $code)';
}


}

/// @nodoc
abstract mixin class $WeatherApiConditionCopyWith<$Res>  {
  factory $WeatherApiConditionCopyWith(WeatherApiCondition value, $Res Function(WeatherApiCondition) _then) = _$WeatherApiConditionCopyWithImpl;
@useResult
$Res call({
 String? text, String? icon,@JsonKey(fromJson: _asInt) int? code
});




}
/// @nodoc
class _$WeatherApiConditionCopyWithImpl<$Res>
    implements $WeatherApiConditionCopyWith<$Res> {
  _$WeatherApiConditionCopyWithImpl(this._self, this._then);

  final WeatherApiCondition _self;
  final $Res Function(WeatherApiCondition) _then;

/// Create a copy of WeatherApiCondition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? icon = freezed,Object? code = freezed,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherApiCondition].
extension WeatherApiConditionPatterns on WeatherApiCondition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherApiCondition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherApiCondition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherApiCondition value)  $default,){
final _that = this;
switch (_that) {
case _WeatherApiCondition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherApiCondition value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherApiCondition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text,  String? icon, @JsonKey(fromJson: _asInt)  int? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherApiCondition() when $default != null:
return $default(_that.text,_that.icon,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text,  String? icon, @JsonKey(fromJson: _asInt)  int? code)  $default,) {final _that = this;
switch (_that) {
case _WeatherApiCondition():
return $default(_that.text,_that.icon,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text,  String? icon, @JsonKey(fromJson: _asInt)  int? code)?  $default,) {final _that = this;
switch (_that) {
case _WeatherApiCondition() when $default != null:
return $default(_that.text,_that.icon,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherApiCondition implements WeatherApiCondition {
  const _WeatherApiCondition({this.text, this.icon, @JsonKey(fromJson: _asInt) this.code});
  factory _WeatherApiCondition.fromJson(Map<String, dynamic> json) => _$WeatherApiConditionFromJson(json);

@override final  String? text;
@override final  String? icon;
@override@JsonKey(fromJson: _asInt) final  int? code;

/// Create a copy of WeatherApiCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherApiConditionCopyWith<_WeatherApiCondition> get copyWith => __$WeatherApiConditionCopyWithImpl<_WeatherApiCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherApiConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherApiCondition&&(identical(other.text, text) || other.text == text)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,icon,code);

@override
String toString() {
  return 'WeatherApiCondition(text: $text, icon: $icon, code: $code)';
}


}

/// @nodoc
abstract mixin class _$WeatherApiConditionCopyWith<$Res> implements $WeatherApiConditionCopyWith<$Res> {
  factory _$WeatherApiConditionCopyWith(_WeatherApiCondition value, $Res Function(_WeatherApiCondition) _then) = __$WeatherApiConditionCopyWithImpl;
@override @useResult
$Res call({
 String? text, String? icon,@JsonKey(fromJson: _asInt) int? code
});




}
/// @nodoc
class __$WeatherApiConditionCopyWithImpl<$Res>
    implements _$WeatherApiConditionCopyWith<$Res> {
  __$WeatherApiConditionCopyWithImpl(this._self, this._then);

  final _WeatherApiCondition _self;
  final $Res Function(_WeatherApiCondition) _then;

/// Create a copy of WeatherApiCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? icon = freezed,Object? code = freezed,}) {
  return _then(_WeatherApiCondition(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$WeatherApiAlerts {

 List<WeatherApiAlert> get alert;
/// Create a copy of WeatherApiAlerts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherApiAlertsCopyWith<WeatherApiAlerts> get copyWith => _$WeatherApiAlertsCopyWithImpl<WeatherApiAlerts>(this as WeatherApiAlerts, _$identity);

  /// Serializes this WeatherApiAlerts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherApiAlerts&&const DeepCollectionEquality().equals(other.alert, alert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(alert));

@override
String toString() {
  return 'WeatherApiAlerts(alert: $alert)';
}


}

/// @nodoc
abstract mixin class $WeatherApiAlertsCopyWith<$Res>  {
  factory $WeatherApiAlertsCopyWith(WeatherApiAlerts value, $Res Function(WeatherApiAlerts) _then) = _$WeatherApiAlertsCopyWithImpl;
@useResult
$Res call({
 List<WeatherApiAlert> alert
});




}
/// @nodoc
class _$WeatherApiAlertsCopyWithImpl<$Res>
    implements $WeatherApiAlertsCopyWith<$Res> {
  _$WeatherApiAlertsCopyWithImpl(this._self, this._then);

  final WeatherApiAlerts _self;
  final $Res Function(WeatherApiAlerts) _then;

/// Create a copy of WeatherApiAlerts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? alert = null,}) {
  return _then(_self.copyWith(
alert: null == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as List<WeatherApiAlert>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherApiAlerts].
extension WeatherApiAlertsPatterns on WeatherApiAlerts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherApiAlerts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherApiAlerts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherApiAlerts value)  $default,){
final _that = this;
switch (_that) {
case _WeatherApiAlerts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherApiAlerts value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherApiAlerts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WeatherApiAlert> alert)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherApiAlerts() when $default != null:
return $default(_that.alert);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WeatherApiAlert> alert)  $default,) {final _that = this;
switch (_that) {
case _WeatherApiAlerts():
return $default(_that.alert);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WeatherApiAlert> alert)?  $default,) {final _that = this;
switch (_that) {
case _WeatherApiAlerts() when $default != null:
return $default(_that.alert);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherApiAlerts implements WeatherApiAlerts {
  const _WeatherApiAlerts({final  List<WeatherApiAlert> alert = const <WeatherApiAlert>[]}): _alert = alert;
  factory _WeatherApiAlerts.fromJson(Map<String, dynamic> json) => _$WeatherApiAlertsFromJson(json);

 final  List<WeatherApiAlert> _alert;
@override@JsonKey() List<WeatherApiAlert> get alert {
  if (_alert is EqualUnmodifiableListView) return _alert;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alert);
}


/// Create a copy of WeatherApiAlerts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherApiAlertsCopyWith<_WeatherApiAlerts> get copyWith => __$WeatherApiAlertsCopyWithImpl<_WeatherApiAlerts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherApiAlertsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherApiAlerts&&const DeepCollectionEquality().equals(other._alert, _alert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_alert));

@override
String toString() {
  return 'WeatherApiAlerts(alert: $alert)';
}


}

/// @nodoc
abstract mixin class _$WeatherApiAlertsCopyWith<$Res> implements $WeatherApiAlertsCopyWith<$Res> {
  factory _$WeatherApiAlertsCopyWith(_WeatherApiAlerts value, $Res Function(_WeatherApiAlerts) _then) = __$WeatherApiAlertsCopyWithImpl;
@override @useResult
$Res call({
 List<WeatherApiAlert> alert
});




}
/// @nodoc
class __$WeatherApiAlertsCopyWithImpl<$Res>
    implements _$WeatherApiAlertsCopyWith<$Res> {
  __$WeatherApiAlertsCopyWithImpl(this._self, this._then);

  final _WeatherApiAlerts _self;
  final $Res Function(_WeatherApiAlerts) _then;

/// Create a copy of WeatherApiAlerts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? alert = null,}) {
  return _then(_WeatherApiAlerts(
alert: null == alert ? _self._alert : alert // ignore: cast_nullable_to_non_nullable
as List<WeatherApiAlert>,
  ));
}


}


/// @nodoc
mixin _$WeatherApiAlert {

 String? get headline; String? get event; String? get effective; String? get expires; String? get desc; String? get instruction;
/// Create a copy of WeatherApiAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherApiAlertCopyWith<WeatherApiAlert> get copyWith => _$WeatherApiAlertCopyWithImpl<WeatherApiAlert>(this as WeatherApiAlert, _$identity);

  /// Serializes this WeatherApiAlert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherApiAlert&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.event, event) || other.event == event)&&(identical(other.effective, effective) || other.effective == effective)&&(identical(other.expires, expires) || other.expires == expires)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.instruction, instruction) || other.instruction == instruction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,headline,event,effective,expires,desc,instruction);

@override
String toString() {
  return 'WeatherApiAlert(headline: $headline, event: $event, effective: $effective, expires: $expires, desc: $desc, instruction: $instruction)';
}


}

/// @nodoc
abstract mixin class $WeatherApiAlertCopyWith<$Res>  {
  factory $WeatherApiAlertCopyWith(WeatherApiAlert value, $Res Function(WeatherApiAlert) _then) = _$WeatherApiAlertCopyWithImpl;
@useResult
$Res call({
 String? headline, String? event, String? effective, String? expires, String? desc, String? instruction
});




}
/// @nodoc
class _$WeatherApiAlertCopyWithImpl<$Res>
    implements $WeatherApiAlertCopyWith<$Res> {
  _$WeatherApiAlertCopyWithImpl(this._self, this._then);

  final WeatherApiAlert _self;
  final $Res Function(WeatherApiAlert) _then;

/// Create a copy of WeatherApiAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headline = freezed,Object? event = freezed,Object? effective = freezed,Object? expires = freezed,Object? desc = freezed,Object? instruction = freezed,}) {
  return _then(_self.copyWith(
headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String?,effective: freezed == effective ? _self.effective : effective // ignore: cast_nullable_to_non_nullable
as String?,expires: freezed == expires ? _self.expires : expires // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,instruction: freezed == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherApiAlert].
extension WeatherApiAlertPatterns on WeatherApiAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherApiAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherApiAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherApiAlert value)  $default,){
final _that = this;
switch (_that) {
case _WeatherApiAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherApiAlert value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherApiAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? headline,  String? event,  String? effective,  String? expires,  String? desc,  String? instruction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherApiAlert() when $default != null:
return $default(_that.headline,_that.event,_that.effective,_that.expires,_that.desc,_that.instruction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? headline,  String? event,  String? effective,  String? expires,  String? desc,  String? instruction)  $default,) {final _that = this;
switch (_that) {
case _WeatherApiAlert():
return $default(_that.headline,_that.event,_that.effective,_that.expires,_that.desc,_that.instruction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? headline,  String? event,  String? effective,  String? expires,  String? desc,  String? instruction)?  $default,) {final _that = this;
switch (_that) {
case _WeatherApiAlert() when $default != null:
return $default(_that.headline,_that.event,_that.effective,_that.expires,_that.desc,_that.instruction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherApiAlert implements WeatherApiAlert {
  const _WeatherApiAlert({this.headline, this.event, this.effective, this.expires, this.desc, this.instruction});
  factory _WeatherApiAlert.fromJson(Map<String, dynamic> json) => _$WeatherApiAlertFromJson(json);

@override final  String? headline;
@override final  String? event;
@override final  String? effective;
@override final  String? expires;
@override final  String? desc;
@override final  String? instruction;

/// Create a copy of WeatherApiAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherApiAlertCopyWith<_WeatherApiAlert> get copyWith => __$WeatherApiAlertCopyWithImpl<_WeatherApiAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherApiAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherApiAlert&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.event, event) || other.event == event)&&(identical(other.effective, effective) || other.effective == effective)&&(identical(other.expires, expires) || other.expires == expires)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.instruction, instruction) || other.instruction == instruction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,headline,event,effective,expires,desc,instruction);

@override
String toString() {
  return 'WeatherApiAlert(headline: $headline, event: $event, effective: $effective, expires: $expires, desc: $desc, instruction: $instruction)';
}


}

/// @nodoc
abstract mixin class _$WeatherApiAlertCopyWith<$Res> implements $WeatherApiAlertCopyWith<$Res> {
  factory _$WeatherApiAlertCopyWith(_WeatherApiAlert value, $Res Function(_WeatherApiAlert) _then) = __$WeatherApiAlertCopyWithImpl;
@override @useResult
$Res call({
 String? headline, String? event, String? effective, String? expires, String? desc, String? instruction
});




}
/// @nodoc
class __$WeatherApiAlertCopyWithImpl<$Res>
    implements _$WeatherApiAlertCopyWith<$Res> {
  __$WeatherApiAlertCopyWithImpl(this._self, this._then);

  final _WeatherApiAlert _self;
  final $Res Function(_WeatherApiAlert) _then;

/// Create a copy of WeatherApiAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headline = freezed,Object? event = freezed,Object? effective = freezed,Object? expires = freezed,Object? desc = freezed,Object? instruction = freezed,}) {
  return _then(_WeatherApiAlert(
headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String?,effective: freezed == effective ? _self.effective : effective // ignore: cast_nullable_to_non_nullable
as String?,expires: freezed == expires ? _self.expires : expires // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,instruction: freezed == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

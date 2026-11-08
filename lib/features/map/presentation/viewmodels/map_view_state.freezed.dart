// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapViewState {

 bool get showEarthquakes; bool get showReports; bool get radarEnabled; bool get isLoadingRadar; bool get isLocating; bool get locationBannerDismissed; List<RadarFrame> get radarFrames; String? get radarError; LatLng? get userLocation; String? get locationError; LocationAvailability? get locationAvailability;
/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapViewStateCopyWith<MapViewState> get copyWith => _$MapViewStateCopyWithImpl<MapViewState>(this as MapViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapViewState&&(identical(other.showEarthquakes, showEarthquakes) || other.showEarthquakes == showEarthquakes)&&(identical(other.showReports, showReports) || other.showReports == showReports)&&(identical(other.radarEnabled, radarEnabled) || other.radarEnabled == radarEnabled)&&(identical(other.isLoadingRadar, isLoadingRadar) || other.isLoadingRadar == isLoadingRadar)&&(identical(other.isLocating, isLocating) || other.isLocating == isLocating)&&(identical(other.locationBannerDismissed, locationBannerDismissed) || other.locationBannerDismissed == locationBannerDismissed)&&const DeepCollectionEquality().equals(other.radarFrames, radarFrames)&&(identical(other.radarError, radarError) || other.radarError == radarError)&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&(identical(other.locationAvailability, locationAvailability) || other.locationAvailability == locationAvailability));
}


@override
int get hashCode => Object.hash(runtimeType,showEarthquakes,showReports,radarEnabled,isLoadingRadar,isLocating,locationBannerDismissed,const DeepCollectionEquality().hash(radarFrames),radarError,userLocation,locationError,locationAvailability);

@override
String toString() {
  return 'MapViewState(showEarthquakes: $showEarthquakes, showReports: $showReports, radarEnabled: $radarEnabled, isLoadingRadar: $isLoadingRadar, isLocating: $isLocating, locationBannerDismissed: $locationBannerDismissed, radarFrames: $radarFrames, radarError: $radarError, userLocation: $userLocation, locationError: $locationError, locationAvailability: $locationAvailability)';
}


}

/// @nodoc
abstract mixin class $MapViewStateCopyWith<$Res>  {
  factory $MapViewStateCopyWith(MapViewState value, $Res Function(MapViewState) _then) = _$MapViewStateCopyWithImpl;
@useResult
$Res call({
 bool showEarthquakes, bool showReports, bool radarEnabled, bool isLoadingRadar, bool isLocating, bool locationBannerDismissed, List<RadarFrame> radarFrames, String? radarError, LatLng? userLocation, String? locationError, LocationAvailability? locationAvailability
});




}
/// @nodoc
class _$MapViewStateCopyWithImpl<$Res>
    implements $MapViewStateCopyWith<$Res> {
  _$MapViewStateCopyWithImpl(this._self, this._then);

  final MapViewState _self;
  final $Res Function(MapViewState) _then;

/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showEarthquakes = null,Object? showReports = null,Object? radarEnabled = null,Object? isLoadingRadar = null,Object? isLocating = null,Object? locationBannerDismissed = null,Object? radarFrames = null,Object? radarError = freezed,Object? userLocation = freezed,Object? locationError = freezed,Object? locationAvailability = freezed,}) {
  return _then(_self.copyWith(
showEarthquakes: null == showEarthquakes ? _self.showEarthquakes : showEarthquakes // ignore: cast_nullable_to_non_nullable
as bool,showReports: null == showReports ? _self.showReports : showReports // ignore: cast_nullable_to_non_nullable
as bool,radarEnabled: null == radarEnabled ? _self.radarEnabled : radarEnabled // ignore: cast_nullable_to_non_nullable
as bool,isLoadingRadar: null == isLoadingRadar ? _self.isLoadingRadar : isLoadingRadar // ignore: cast_nullable_to_non_nullable
as bool,isLocating: null == isLocating ? _self.isLocating : isLocating // ignore: cast_nullable_to_non_nullable
as bool,locationBannerDismissed: null == locationBannerDismissed ? _self.locationBannerDismissed : locationBannerDismissed // ignore: cast_nullable_to_non_nullable
as bool,radarFrames: null == radarFrames ? _self.radarFrames : radarFrames // ignore: cast_nullable_to_non_nullable
as List<RadarFrame>,radarError: freezed == radarError ? _self.radarError : radarError // ignore: cast_nullable_to_non_nullable
as String?,userLocation: freezed == userLocation ? _self.userLocation : userLocation // ignore: cast_nullable_to_non_nullable
as LatLng?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as String?,locationAvailability: freezed == locationAvailability ? _self.locationAvailability : locationAvailability // ignore: cast_nullable_to_non_nullable
as LocationAvailability?,
  ));
}

}


/// Adds pattern-matching-related methods to [MapViewState].
extension MapViewStatePatterns on MapViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapViewState value)  $default,){
final _that = this;
switch (_that) {
case _MapViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapViewState value)?  $default,){
final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showEarthquakes,  bool showReports,  bool radarEnabled,  bool isLoadingRadar,  bool isLocating,  bool locationBannerDismissed,  List<RadarFrame> radarFrames,  String? radarError,  LatLng? userLocation,  String? locationError,  LocationAvailability? locationAvailability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
return $default(_that.showEarthquakes,_that.showReports,_that.radarEnabled,_that.isLoadingRadar,_that.isLocating,_that.locationBannerDismissed,_that.radarFrames,_that.radarError,_that.userLocation,_that.locationError,_that.locationAvailability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showEarthquakes,  bool showReports,  bool radarEnabled,  bool isLoadingRadar,  bool isLocating,  bool locationBannerDismissed,  List<RadarFrame> radarFrames,  String? radarError,  LatLng? userLocation,  String? locationError,  LocationAvailability? locationAvailability)  $default,) {final _that = this;
switch (_that) {
case _MapViewState():
return $default(_that.showEarthquakes,_that.showReports,_that.radarEnabled,_that.isLoadingRadar,_that.isLocating,_that.locationBannerDismissed,_that.radarFrames,_that.radarError,_that.userLocation,_that.locationError,_that.locationAvailability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showEarthquakes,  bool showReports,  bool radarEnabled,  bool isLoadingRadar,  bool isLocating,  bool locationBannerDismissed,  List<RadarFrame> radarFrames,  String? radarError,  LatLng? userLocation,  String? locationError,  LocationAvailability? locationAvailability)?  $default,) {final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
return $default(_that.showEarthquakes,_that.showReports,_that.radarEnabled,_that.isLoadingRadar,_that.isLocating,_that.locationBannerDismissed,_that.radarFrames,_that.radarError,_that.userLocation,_that.locationError,_that.locationAvailability);case _:
  return null;

}
}

}

/// @nodoc


class _MapViewState extends MapViewState {
  const _MapViewState({this.showEarthquakes = true, this.showReports = true, this.radarEnabled = false, this.isLoadingRadar = false, this.isLocating = false, this.locationBannerDismissed = false, final  List<RadarFrame> radarFrames = const <RadarFrame>[], this.radarError, this.userLocation, this.locationError, this.locationAvailability}): _radarFrames = radarFrames,super._();
  

@override@JsonKey() final  bool showEarthquakes;
@override@JsonKey() final  bool showReports;
@override@JsonKey() final  bool radarEnabled;
@override@JsonKey() final  bool isLoadingRadar;
@override@JsonKey() final  bool isLocating;
@override@JsonKey() final  bool locationBannerDismissed;
 final  List<RadarFrame> _radarFrames;
@override@JsonKey() List<RadarFrame> get radarFrames {
  if (_radarFrames is EqualUnmodifiableListView) return _radarFrames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_radarFrames);
}

@override final  String? radarError;
@override final  LatLng? userLocation;
@override final  String? locationError;
@override final  LocationAvailability? locationAvailability;

/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapViewStateCopyWith<_MapViewState> get copyWith => __$MapViewStateCopyWithImpl<_MapViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapViewState&&(identical(other.showEarthquakes, showEarthquakes) || other.showEarthquakes == showEarthquakes)&&(identical(other.showReports, showReports) || other.showReports == showReports)&&(identical(other.radarEnabled, radarEnabled) || other.radarEnabled == radarEnabled)&&(identical(other.isLoadingRadar, isLoadingRadar) || other.isLoadingRadar == isLoadingRadar)&&(identical(other.isLocating, isLocating) || other.isLocating == isLocating)&&(identical(other.locationBannerDismissed, locationBannerDismissed) || other.locationBannerDismissed == locationBannerDismissed)&&const DeepCollectionEquality().equals(other._radarFrames, _radarFrames)&&(identical(other.radarError, radarError) || other.radarError == radarError)&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&(identical(other.locationAvailability, locationAvailability) || other.locationAvailability == locationAvailability));
}


@override
int get hashCode => Object.hash(runtimeType,showEarthquakes,showReports,radarEnabled,isLoadingRadar,isLocating,locationBannerDismissed,const DeepCollectionEquality().hash(_radarFrames),radarError,userLocation,locationError,locationAvailability);

@override
String toString() {
  return 'MapViewState(showEarthquakes: $showEarthquakes, showReports: $showReports, radarEnabled: $radarEnabled, isLoadingRadar: $isLoadingRadar, isLocating: $isLocating, locationBannerDismissed: $locationBannerDismissed, radarFrames: $radarFrames, radarError: $radarError, userLocation: $userLocation, locationError: $locationError, locationAvailability: $locationAvailability)';
}


}

/// @nodoc
abstract mixin class _$MapViewStateCopyWith<$Res> implements $MapViewStateCopyWith<$Res> {
  factory _$MapViewStateCopyWith(_MapViewState value, $Res Function(_MapViewState) _then) = __$MapViewStateCopyWithImpl;
@override @useResult
$Res call({
 bool showEarthquakes, bool showReports, bool radarEnabled, bool isLoadingRadar, bool isLocating, bool locationBannerDismissed, List<RadarFrame> radarFrames, String? radarError, LatLng? userLocation, String? locationError, LocationAvailability? locationAvailability
});




}
/// @nodoc
class __$MapViewStateCopyWithImpl<$Res>
    implements _$MapViewStateCopyWith<$Res> {
  __$MapViewStateCopyWithImpl(this._self, this._then);

  final _MapViewState _self;
  final $Res Function(_MapViewState) _then;

/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showEarthquakes = null,Object? showReports = null,Object? radarEnabled = null,Object? isLoadingRadar = null,Object? isLocating = null,Object? locationBannerDismissed = null,Object? radarFrames = null,Object? radarError = freezed,Object? userLocation = freezed,Object? locationError = freezed,Object? locationAvailability = freezed,}) {
  return _then(_MapViewState(
showEarthquakes: null == showEarthquakes ? _self.showEarthquakes : showEarthquakes // ignore: cast_nullable_to_non_nullable
as bool,showReports: null == showReports ? _self.showReports : showReports // ignore: cast_nullable_to_non_nullable
as bool,radarEnabled: null == radarEnabled ? _self.radarEnabled : radarEnabled // ignore: cast_nullable_to_non_nullable
as bool,isLoadingRadar: null == isLoadingRadar ? _self.isLoadingRadar : isLoadingRadar // ignore: cast_nullable_to_non_nullable
as bool,isLocating: null == isLocating ? _self.isLocating : isLocating // ignore: cast_nullable_to_non_nullable
as bool,locationBannerDismissed: null == locationBannerDismissed ? _self.locationBannerDismissed : locationBannerDismissed // ignore: cast_nullable_to_non_nullable
as bool,radarFrames: null == radarFrames ? _self._radarFrames : radarFrames // ignore: cast_nullable_to_non_nullable
as List<RadarFrame>,radarError: freezed == radarError ? _self.radarError : radarError // ignore: cast_nullable_to_non_nullable
as String?,userLocation: freezed == userLocation ? _self.userLocation : userLocation // ignore: cast_nullable_to_non_nullable
as LatLng?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as String?,locationAvailability: freezed == locationAvailability ? _self.locationAvailability : locationAvailability // ignore: cast_nullable_to_non_nullable
as LocationAvailability?,
  ));
}


}

// dart format on

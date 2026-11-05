// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rainviewer_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RainViewerResponse {

 String? get version; int? get generated; String? get host; RainViewerRadar? get radar;
/// Create a copy of RainViewerResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RainViewerResponseCopyWith<RainViewerResponse> get copyWith => _$RainViewerResponseCopyWithImpl<RainViewerResponse>(this as RainViewerResponse, _$identity);

  /// Serializes this RainViewerResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RainViewerResponse&&(identical(other.version, version) || other.version == version)&&(identical(other.generated, generated) || other.generated == generated)&&(identical(other.host, host) || other.host == host)&&(identical(other.radar, radar) || other.radar == radar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,generated,host,radar);

@override
String toString() {
  return 'RainViewerResponse(version: $version, generated: $generated, host: $host, radar: $radar)';
}


}

/// @nodoc
abstract mixin class $RainViewerResponseCopyWith<$Res>  {
  factory $RainViewerResponseCopyWith(RainViewerResponse value, $Res Function(RainViewerResponse) _then) = _$RainViewerResponseCopyWithImpl;
@useResult
$Res call({
 String? version, int? generated, String? host, RainViewerRadar? radar
});


$RainViewerRadarCopyWith<$Res>? get radar;

}
/// @nodoc
class _$RainViewerResponseCopyWithImpl<$Res>
    implements $RainViewerResponseCopyWith<$Res> {
  _$RainViewerResponseCopyWithImpl(this._self, this._then);

  final RainViewerResponse _self;
  final $Res Function(RainViewerResponse) _then;

/// Create a copy of RainViewerResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = freezed,Object? generated = freezed,Object? host = freezed,Object? radar = freezed,}) {
  return _then(_self.copyWith(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,generated: freezed == generated ? _self.generated : generated // ignore: cast_nullable_to_non_nullable
as int?,host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,radar: freezed == radar ? _self.radar : radar // ignore: cast_nullable_to_non_nullable
as RainViewerRadar?,
  ));
}
/// Create a copy of RainViewerResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RainViewerRadarCopyWith<$Res>? get radar {
    if (_self.radar == null) {
    return null;
  }

  return $RainViewerRadarCopyWith<$Res>(_self.radar!, (value) {
    return _then(_self.copyWith(radar: value));
  });
}
}


/// Adds pattern-matching-related methods to [RainViewerResponse].
extension RainViewerResponsePatterns on RainViewerResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RainViewerResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RainViewerResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RainViewerResponse value)  $default,){
final _that = this;
switch (_that) {
case _RainViewerResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RainViewerResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RainViewerResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? version,  int? generated,  String? host,  RainViewerRadar? radar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RainViewerResponse() when $default != null:
return $default(_that.version,_that.generated,_that.host,_that.radar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? version,  int? generated,  String? host,  RainViewerRadar? radar)  $default,) {final _that = this;
switch (_that) {
case _RainViewerResponse():
return $default(_that.version,_that.generated,_that.host,_that.radar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? version,  int? generated,  String? host,  RainViewerRadar? radar)?  $default,) {final _that = this;
switch (_that) {
case _RainViewerResponse() when $default != null:
return $default(_that.version,_that.generated,_that.host,_that.radar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RainViewerResponse implements RainViewerResponse {
  const _RainViewerResponse({this.version, this.generated, this.host, this.radar});
  factory _RainViewerResponse.fromJson(Map<String, dynamic> json) => _$RainViewerResponseFromJson(json);

@override final  String? version;
@override final  int? generated;
@override final  String? host;
@override final  RainViewerRadar? radar;

/// Create a copy of RainViewerResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RainViewerResponseCopyWith<_RainViewerResponse> get copyWith => __$RainViewerResponseCopyWithImpl<_RainViewerResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RainViewerResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RainViewerResponse&&(identical(other.version, version) || other.version == version)&&(identical(other.generated, generated) || other.generated == generated)&&(identical(other.host, host) || other.host == host)&&(identical(other.radar, radar) || other.radar == radar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,generated,host,radar);

@override
String toString() {
  return 'RainViewerResponse(version: $version, generated: $generated, host: $host, radar: $radar)';
}


}

/// @nodoc
abstract mixin class _$RainViewerResponseCopyWith<$Res> implements $RainViewerResponseCopyWith<$Res> {
  factory _$RainViewerResponseCopyWith(_RainViewerResponse value, $Res Function(_RainViewerResponse) _then) = __$RainViewerResponseCopyWithImpl;
@override @useResult
$Res call({
 String? version, int? generated, String? host, RainViewerRadar? radar
});


@override $RainViewerRadarCopyWith<$Res>? get radar;

}
/// @nodoc
class __$RainViewerResponseCopyWithImpl<$Res>
    implements _$RainViewerResponseCopyWith<$Res> {
  __$RainViewerResponseCopyWithImpl(this._self, this._then);

  final _RainViewerResponse _self;
  final $Res Function(_RainViewerResponse) _then;

/// Create a copy of RainViewerResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = freezed,Object? generated = freezed,Object? host = freezed,Object? radar = freezed,}) {
  return _then(_RainViewerResponse(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,generated: freezed == generated ? _self.generated : generated // ignore: cast_nullable_to_non_nullable
as int?,host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,radar: freezed == radar ? _self.radar : radar // ignore: cast_nullable_to_non_nullable
as RainViewerRadar?,
  ));
}

/// Create a copy of RainViewerResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RainViewerRadarCopyWith<$Res>? get radar {
    if (_self.radar == null) {
    return null;
  }

  return $RainViewerRadarCopyWith<$Res>(_self.radar!, (value) {
    return _then(_self.copyWith(radar: value));
  });
}
}


/// @nodoc
mixin _$RainViewerRadar {

 List<RainViewerFrame> get past; List<RainViewerFrame> get nowcast;
/// Create a copy of RainViewerRadar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RainViewerRadarCopyWith<RainViewerRadar> get copyWith => _$RainViewerRadarCopyWithImpl<RainViewerRadar>(this as RainViewerRadar, _$identity);

  /// Serializes this RainViewerRadar to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RainViewerRadar&&const DeepCollectionEquality().equals(other.past, past)&&const DeepCollectionEquality().equals(other.nowcast, nowcast));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(past),const DeepCollectionEquality().hash(nowcast));

@override
String toString() {
  return 'RainViewerRadar(past: $past, nowcast: $nowcast)';
}


}

/// @nodoc
abstract mixin class $RainViewerRadarCopyWith<$Res>  {
  factory $RainViewerRadarCopyWith(RainViewerRadar value, $Res Function(RainViewerRadar) _then) = _$RainViewerRadarCopyWithImpl;
@useResult
$Res call({
 List<RainViewerFrame> past, List<RainViewerFrame> nowcast
});




}
/// @nodoc
class _$RainViewerRadarCopyWithImpl<$Res>
    implements $RainViewerRadarCopyWith<$Res> {
  _$RainViewerRadarCopyWithImpl(this._self, this._then);

  final RainViewerRadar _self;
  final $Res Function(RainViewerRadar) _then;

/// Create a copy of RainViewerRadar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? past = null,Object? nowcast = null,}) {
  return _then(_self.copyWith(
past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as List<RainViewerFrame>,nowcast: null == nowcast ? _self.nowcast : nowcast // ignore: cast_nullable_to_non_nullable
as List<RainViewerFrame>,
  ));
}

}


/// Adds pattern-matching-related methods to [RainViewerRadar].
extension RainViewerRadarPatterns on RainViewerRadar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RainViewerRadar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RainViewerRadar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RainViewerRadar value)  $default,){
final _that = this;
switch (_that) {
case _RainViewerRadar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RainViewerRadar value)?  $default,){
final _that = this;
switch (_that) {
case _RainViewerRadar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RainViewerFrame> past,  List<RainViewerFrame> nowcast)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RainViewerRadar() when $default != null:
return $default(_that.past,_that.nowcast);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RainViewerFrame> past,  List<RainViewerFrame> nowcast)  $default,) {final _that = this;
switch (_that) {
case _RainViewerRadar():
return $default(_that.past,_that.nowcast);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RainViewerFrame> past,  List<RainViewerFrame> nowcast)?  $default,) {final _that = this;
switch (_that) {
case _RainViewerRadar() when $default != null:
return $default(_that.past,_that.nowcast);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RainViewerRadar implements RainViewerRadar {
  const _RainViewerRadar({final  List<RainViewerFrame> past = const <RainViewerFrame>[], final  List<RainViewerFrame> nowcast = const <RainViewerFrame>[]}): _past = past,_nowcast = nowcast;
  factory _RainViewerRadar.fromJson(Map<String, dynamic> json) => _$RainViewerRadarFromJson(json);

 final  List<RainViewerFrame> _past;
@override@JsonKey() List<RainViewerFrame> get past {
  if (_past is EqualUnmodifiableListView) return _past;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_past);
}

 final  List<RainViewerFrame> _nowcast;
@override@JsonKey() List<RainViewerFrame> get nowcast {
  if (_nowcast is EqualUnmodifiableListView) return _nowcast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nowcast);
}


/// Create a copy of RainViewerRadar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RainViewerRadarCopyWith<_RainViewerRadar> get copyWith => __$RainViewerRadarCopyWithImpl<_RainViewerRadar>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RainViewerRadarToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RainViewerRadar&&const DeepCollectionEquality().equals(other._past, _past)&&const DeepCollectionEquality().equals(other._nowcast, _nowcast));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_past),const DeepCollectionEquality().hash(_nowcast));

@override
String toString() {
  return 'RainViewerRadar(past: $past, nowcast: $nowcast)';
}


}

/// @nodoc
abstract mixin class _$RainViewerRadarCopyWith<$Res> implements $RainViewerRadarCopyWith<$Res> {
  factory _$RainViewerRadarCopyWith(_RainViewerRadar value, $Res Function(_RainViewerRadar) _then) = __$RainViewerRadarCopyWithImpl;
@override @useResult
$Res call({
 List<RainViewerFrame> past, List<RainViewerFrame> nowcast
});




}
/// @nodoc
class __$RainViewerRadarCopyWithImpl<$Res>
    implements _$RainViewerRadarCopyWith<$Res> {
  __$RainViewerRadarCopyWithImpl(this._self, this._then);

  final _RainViewerRadar _self;
  final $Res Function(_RainViewerRadar) _then;

/// Create a copy of RainViewerRadar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? past = null,Object? nowcast = null,}) {
  return _then(_RainViewerRadar(
past: null == past ? _self._past : past // ignore: cast_nullable_to_non_nullable
as List<RainViewerFrame>,nowcast: null == nowcast ? _self._nowcast : nowcast // ignore: cast_nullable_to_non_nullable
as List<RainViewerFrame>,
  ));
}


}


/// @nodoc
mixin _$RainViewerFrame {

 int? get time; String? get path;
/// Create a copy of RainViewerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RainViewerFrameCopyWith<RainViewerFrame> get copyWith => _$RainViewerFrameCopyWithImpl<RainViewerFrame>(this as RainViewerFrame, _$identity);

  /// Serializes this RainViewerFrame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RainViewerFrame&&(identical(other.time, time) || other.time == time)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,path);

@override
String toString() {
  return 'RainViewerFrame(time: $time, path: $path)';
}


}

/// @nodoc
abstract mixin class $RainViewerFrameCopyWith<$Res>  {
  factory $RainViewerFrameCopyWith(RainViewerFrame value, $Res Function(RainViewerFrame) _then) = _$RainViewerFrameCopyWithImpl;
@useResult
$Res call({
 int? time, String? path
});




}
/// @nodoc
class _$RainViewerFrameCopyWithImpl<$Res>
    implements $RainViewerFrameCopyWith<$Res> {
  _$RainViewerFrameCopyWithImpl(this._self, this._then);

  final RainViewerFrame _self;
  final $Res Function(RainViewerFrame) _then;

/// Create a copy of RainViewerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = freezed,Object? path = freezed,}) {
  return _then(_self.copyWith(
time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RainViewerFrame].
extension RainViewerFramePatterns on RainViewerFrame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RainViewerFrame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RainViewerFrame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RainViewerFrame value)  $default,){
final _that = this;
switch (_that) {
case _RainViewerFrame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RainViewerFrame value)?  $default,){
final _that = this;
switch (_that) {
case _RainViewerFrame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? time,  String? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RainViewerFrame() when $default != null:
return $default(_that.time,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? time,  String? path)  $default,) {final _that = this;
switch (_that) {
case _RainViewerFrame():
return $default(_that.time,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? time,  String? path)?  $default,) {final _that = this;
switch (_that) {
case _RainViewerFrame() when $default != null:
return $default(_that.time,_that.path);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RainViewerFrame implements RainViewerFrame {
  const _RainViewerFrame({this.time, this.path});
  factory _RainViewerFrame.fromJson(Map<String, dynamic> json) => _$RainViewerFrameFromJson(json);

@override final  int? time;
@override final  String? path;

/// Create a copy of RainViewerFrame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RainViewerFrameCopyWith<_RainViewerFrame> get copyWith => __$RainViewerFrameCopyWithImpl<_RainViewerFrame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RainViewerFrameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RainViewerFrame&&(identical(other.time, time) || other.time == time)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,path);

@override
String toString() {
  return 'RainViewerFrame(time: $time, path: $path)';
}


}

/// @nodoc
abstract mixin class _$RainViewerFrameCopyWith<$Res> implements $RainViewerFrameCopyWith<$Res> {
  factory _$RainViewerFrameCopyWith(_RainViewerFrame value, $Res Function(_RainViewerFrame) _then) = __$RainViewerFrameCopyWithImpl;
@override @useResult
$Res call({
 int? time, String? path
});




}
/// @nodoc
class __$RainViewerFrameCopyWithImpl<$Res>
    implements _$RainViewerFrameCopyWith<$Res> {
  __$RainViewerFrameCopyWithImpl(this._self, this._then);

  final _RainViewerFrame _self;
  final $Res Function(_RainViewerFrame) _then;

/// Create a copy of RainViewerFrame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = freezed,Object? path = freezed,}) {
  return _then(_RainViewerFrame(
time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherAlert {

 String get senderName; String get event; DateTime get start; DateTime get end; String get description; List<String> get tags;
/// Create a copy of WeatherAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherAlertCopyWith<WeatherAlert> get copyWith => _$WeatherAlertCopyWithImpl<WeatherAlert>(this as WeatherAlert, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherAlert&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.event, event) || other.event == event)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,senderName,event,start,end,description,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'WeatherAlert(senderName: $senderName, event: $event, start: $start, end: $end, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $WeatherAlertCopyWith<$Res>  {
  factory $WeatherAlertCopyWith(WeatherAlert value, $Res Function(WeatherAlert) _then) = _$WeatherAlertCopyWithImpl;
@useResult
$Res call({
 String senderName, String event, DateTime start, DateTime end, String description, List<String> tags
});




}
/// @nodoc
class _$WeatherAlertCopyWithImpl<$Res>
    implements $WeatherAlertCopyWith<$Res> {
  _$WeatherAlertCopyWithImpl(this._self, this._then);

  final WeatherAlert _self;
  final $Res Function(WeatherAlert) _then;

/// Create a copy of WeatherAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? senderName = null,Object? event = null,Object? start = null,Object? end = null,Object? description = null,Object? tags = null,}) {
  return _then(_self.copyWith(
senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherAlert].
extension WeatherAlertPatterns on WeatherAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherAlert value)  $default,){
final _that = this;
switch (_that) {
case _WeatherAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherAlert value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String senderName,  String event,  DateTime start,  DateTime end,  String description,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherAlert() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String senderName,  String event,  DateTime start,  DateTime end,  String description,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _WeatherAlert():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String senderName,  String event,  DateTime start,  DateTime end,  String description,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _WeatherAlert() when $default != null:
return $default(_that.senderName,_that.event,_that.start,_that.end,_that.description,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherAlert extends WeatherAlert {
  const _WeatherAlert({required this.senderName, required this.event, required this.start, required this.end, required this.description, final  List<String> tags = const <String>[]}): _tags = tags,super._();
  

@override final  String senderName;
@override final  String event;
@override final  DateTime start;
@override final  DateTime end;
@override final  String description;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of WeatherAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherAlertCopyWith<_WeatherAlert> get copyWith => __$WeatherAlertCopyWithImpl<_WeatherAlert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherAlert&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.event, event) || other.event == event)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,senderName,event,start,end,description,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'WeatherAlert(senderName: $senderName, event: $event, start: $start, end: $end, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$WeatherAlertCopyWith<$Res> implements $WeatherAlertCopyWith<$Res> {
  factory _$WeatherAlertCopyWith(_WeatherAlert value, $Res Function(_WeatherAlert) _then) = __$WeatherAlertCopyWithImpl;
@override @useResult
$Res call({
 String senderName, String event, DateTime start, DateTime end, String description, List<String> tags
});




}
/// @nodoc
class __$WeatherAlertCopyWithImpl<$Res>
    implements _$WeatherAlertCopyWith<$Res> {
  __$WeatherAlertCopyWithImpl(this._self, this._then);

  final _WeatherAlert _self;
  final $Res Function(_WeatherAlert) _then;

/// Create a copy of WeatherAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? senderName = null,Object? event = null,Object? start = null,Object? end = null,Object? description = null,Object? tags = null,}) {
  return _then(_WeatherAlert(
senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

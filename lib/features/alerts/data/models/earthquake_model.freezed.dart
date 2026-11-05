// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UsgsFeatureCollection {

 List<UsgsFeature> get features;
/// Create a copy of UsgsFeatureCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsgsFeatureCollectionCopyWith<UsgsFeatureCollection> get copyWith => _$UsgsFeatureCollectionCopyWithImpl<UsgsFeatureCollection>(this as UsgsFeatureCollection, _$identity);

  /// Serializes this UsgsFeatureCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsgsFeatureCollection&&const DeepCollectionEquality().equals(other.features, features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(features));

@override
String toString() {
  return 'UsgsFeatureCollection(features: $features)';
}


}

/// @nodoc
abstract mixin class $UsgsFeatureCollectionCopyWith<$Res>  {
  factory $UsgsFeatureCollectionCopyWith(UsgsFeatureCollection value, $Res Function(UsgsFeatureCollection) _then) = _$UsgsFeatureCollectionCopyWithImpl;
@useResult
$Res call({
 List<UsgsFeature> features
});




}
/// @nodoc
class _$UsgsFeatureCollectionCopyWithImpl<$Res>
    implements $UsgsFeatureCollectionCopyWith<$Res> {
  _$UsgsFeatureCollectionCopyWithImpl(this._self, this._then);

  final UsgsFeatureCollection _self;
  final $Res Function(UsgsFeatureCollection) _then;

/// Create a copy of UsgsFeatureCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? features = null,}) {
  return _then(_self.copyWith(
features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<UsgsFeature>,
  ));
}

}


/// Adds pattern-matching-related methods to [UsgsFeatureCollection].
extension UsgsFeatureCollectionPatterns on UsgsFeatureCollection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsgsFeatureCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsgsFeatureCollection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsgsFeatureCollection value)  $default,){
final _that = this;
switch (_that) {
case _UsgsFeatureCollection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsgsFeatureCollection value)?  $default,){
final _that = this;
switch (_that) {
case _UsgsFeatureCollection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UsgsFeature> features)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsgsFeatureCollection() when $default != null:
return $default(_that.features);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UsgsFeature> features)  $default,) {final _that = this;
switch (_that) {
case _UsgsFeatureCollection():
return $default(_that.features);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UsgsFeature> features)?  $default,) {final _that = this;
switch (_that) {
case _UsgsFeatureCollection() when $default != null:
return $default(_that.features);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsgsFeatureCollection implements UsgsFeatureCollection {
  const _UsgsFeatureCollection({final  List<UsgsFeature> features = const <UsgsFeature>[]}): _features = features;
  factory _UsgsFeatureCollection.fromJson(Map<String, dynamic> json) => _$UsgsFeatureCollectionFromJson(json);

 final  List<UsgsFeature> _features;
@override@JsonKey() List<UsgsFeature> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}


/// Create a copy of UsgsFeatureCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsgsFeatureCollectionCopyWith<_UsgsFeatureCollection> get copyWith => __$UsgsFeatureCollectionCopyWithImpl<_UsgsFeatureCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsgsFeatureCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsgsFeatureCollection&&const DeepCollectionEquality().equals(other._features, _features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_features));

@override
String toString() {
  return 'UsgsFeatureCollection(features: $features)';
}


}

/// @nodoc
abstract mixin class _$UsgsFeatureCollectionCopyWith<$Res> implements $UsgsFeatureCollectionCopyWith<$Res> {
  factory _$UsgsFeatureCollectionCopyWith(_UsgsFeatureCollection value, $Res Function(_UsgsFeatureCollection) _then) = __$UsgsFeatureCollectionCopyWithImpl;
@override @useResult
$Res call({
 List<UsgsFeature> features
});




}
/// @nodoc
class __$UsgsFeatureCollectionCopyWithImpl<$Res>
    implements _$UsgsFeatureCollectionCopyWith<$Res> {
  __$UsgsFeatureCollectionCopyWithImpl(this._self, this._then);

  final _UsgsFeatureCollection _self;
  final $Res Function(_UsgsFeatureCollection) _then;

/// Create a copy of UsgsFeatureCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? features = null,}) {
  return _then(_UsgsFeatureCollection(
features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<UsgsFeature>,
  ));
}


}


/// @nodoc
mixin _$UsgsFeature {

 String get id; UsgsProperties get properties; UsgsGeometry get geometry;
/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsgsFeatureCopyWith<UsgsFeature> get copyWith => _$UsgsFeatureCopyWithImpl<UsgsFeature>(this as UsgsFeature, _$identity);

  /// Serializes this UsgsFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsgsFeature&&(identical(other.id, id) || other.id == id)&&(identical(other.properties, properties) || other.properties == properties)&&(identical(other.geometry, geometry) || other.geometry == geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,properties,geometry);

@override
String toString() {
  return 'UsgsFeature(id: $id, properties: $properties, geometry: $geometry)';
}


}

/// @nodoc
abstract mixin class $UsgsFeatureCopyWith<$Res>  {
  factory $UsgsFeatureCopyWith(UsgsFeature value, $Res Function(UsgsFeature) _then) = _$UsgsFeatureCopyWithImpl;
@useResult
$Res call({
 String id, UsgsProperties properties, UsgsGeometry geometry
});


$UsgsPropertiesCopyWith<$Res> get properties;$UsgsGeometryCopyWith<$Res> get geometry;

}
/// @nodoc
class _$UsgsFeatureCopyWithImpl<$Res>
    implements $UsgsFeatureCopyWith<$Res> {
  _$UsgsFeatureCopyWithImpl(this._self, this._then);

  final UsgsFeature _self;
  final $Res Function(UsgsFeature) _then;

/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? properties = null,Object? geometry = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as UsgsProperties,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as UsgsGeometry,
  ));
}
/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsgsPropertiesCopyWith<$Res> get properties {
  
  return $UsgsPropertiesCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsgsGeometryCopyWith<$Res> get geometry {
  
  return $UsgsGeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// Adds pattern-matching-related methods to [UsgsFeature].
extension UsgsFeaturePatterns on UsgsFeature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsgsFeature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsgsFeature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsgsFeature value)  $default,){
final _that = this;
switch (_that) {
case _UsgsFeature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsgsFeature value)?  $default,){
final _that = this;
switch (_that) {
case _UsgsFeature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UsgsProperties properties,  UsgsGeometry geometry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsgsFeature() when $default != null:
return $default(_that.id,_that.properties,_that.geometry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UsgsProperties properties,  UsgsGeometry geometry)  $default,) {final _that = this;
switch (_that) {
case _UsgsFeature():
return $default(_that.id,_that.properties,_that.geometry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UsgsProperties properties,  UsgsGeometry geometry)?  $default,) {final _that = this;
switch (_that) {
case _UsgsFeature() when $default != null:
return $default(_that.id,_that.properties,_that.geometry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsgsFeature implements UsgsFeature {
  const _UsgsFeature({required this.id, required this.properties, required this.geometry});
  factory _UsgsFeature.fromJson(Map<String, dynamic> json) => _$UsgsFeatureFromJson(json);

@override final  String id;
@override final  UsgsProperties properties;
@override final  UsgsGeometry geometry;

/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsgsFeatureCopyWith<_UsgsFeature> get copyWith => __$UsgsFeatureCopyWithImpl<_UsgsFeature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsgsFeatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsgsFeature&&(identical(other.id, id) || other.id == id)&&(identical(other.properties, properties) || other.properties == properties)&&(identical(other.geometry, geometry) || other.geometry == geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,properties,geometry);

@override
String toString() {
  return 'UsgsFeature(id: $id, properties: $properties, geometry: $geometry)';
}


}

/// @nodoc
abstract mixin class _$UsgsFeatureCopyWith<$Res> implements $UsgsFeatureCopyWith<$Res> {
  factory _$UsgsFeatureCopyWith(_UsgsFeature value, $Res Function(_UsgsFeature) _then) = __$UsgsFeatureCopyWithImpl;
@override @useResult
$Res call({
 String id, UsgsProperties properties, UsgsGeometry geometry
});


@override $UsgsPropertiesCopyWith<$Res> get properties;@override $UsgsGeometryCopyWith<$Res> get geometry;

}
/// @nodoc
class __$UsgsFeatureCopyWithImpl<$Res>
    implements _$UsgsFeatureCopyWith<$Res> {
  __$UsgsFeatureCopyWithImpl(this._self, this._then);

  final _UsgsFeature _self;
  final $Res Function(_UsgsFeature) _then;

/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? properties = null,Object? geometry = null,}) {
  return _then(_UsgsFeature(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as UsgsProperties,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as UsgsGeometry,
  ));
}

/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsgsPropertiesCopyWith<$Res> get properties {
  
  return $UsgsPropertiesCopyWith<$Res>(_self.properties, (value) {
    return _then(_self.copyWith(properties: value));
  });
}/// Create a copy of UsgsFeature
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsgsGeometryCopyWith<$Res> get geometry {
  
  return $UsgsGeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// @nodoc
mixin _$UsgsProperties {

@JsonKey(fromJson: _asDouble) double? get mag; String? get place; int? get time; String? get alert; String? get status; int? get tsunami; String? get title; String? get url; int? get sig; String? get type;
/// Create a copy of UsgsProperties
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsgsPropertiesCopyWith<UsgsProperties> get copyWith => _$UsgsPropertiesCopyWithImpl<UsgsProperties>(this as UsgsProperties, _$identity);

  /// Serializes this UsgsProperties to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsgsProperties&&(identical(other.mag, mag) || other.mag == mag)&&(identical(other.place, place) || other.place == place)&&(identical(other.time, time) || other.time == time)&&(identical(other.alert, alert) || other.alert == alert)&&(identical(other.status, status) || other.status == status)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.sig, sig) || other.sig == sig)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mag,place,time,alert,status,tsunami,title,url,sig,type);

@override
String toString() {
  return 'UsgsProperties(mag: $mag, place: $place, time: $time, alert: $alert, status: $status, tsunami: $tsunami, title: $title, url: $url, sig: $sig, type: $type)';
}


}

/// @nodoc
abstract mixin class $UsgsPropertiesCopyWith<$Res>  {
  factory $UsgsPropertiesCopyWith(UsgsProperties value, $Res Function(UsgsProperties) _then) = _$UsgsPropertiesCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _asDouble) double? mag, String? place, int? time, String? alert, String? status, int? tsunami, String? title, String? url, int? sig, String? type
});




}
/// @nodoc
class _$UsgsPropertiesCopyWithImpl<$Res>
    implements $UsgsPropertiesCopyWith<$Res> {
  _$UsgsPropertiesCopyWithImpl(this._self, this._then);

  final UsgsProperties _self;
  final $Res Function(UsgsProperties) _then;

/// Create a copy of UsgsProperties
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mag = freezed,Object? place = freezed,Object? time = freezed,Object? alert = freezed,Object? status = freezed,Object? tsunami = freezed,Object? title = freezed,Object? url = freezed,Object? sig = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
mag: freezed == mag ? _self.mag : mag // ignore: cast_nullable_to_non_nullable
as double?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int?,alert: freezed == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,tsunami: freezed == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,sig: freezed == sig ? _self.sig : sig // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UsgsProperties].
extension UsgsPropertiesPatterns on UsgsProperties {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsgsProperties value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsgsProperties() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsgsProperties value)  $default,){
final _that = this;
switch (_that) {
case _UsgsProperties():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsgsProperties value)?  $default,){
final _that = this;
switch (_that) {
case _UsgsProperties() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _asDouble)  double? mag,  String? place,  int? time,  String? alert,  String? status,  int? tsunami,  String? title,  String? url,  int? sig,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsgsProperties() when $default != null:
return $default(_that.mag,_that.place,_that.time,_that.alert,_that.status,_that.tsunami,_that.title,_that.url,_that.sig,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _asDouble)  double? mag,  String? place,  int? time,  String? alert,  String? status,  int? tsunami,  String? title,  String? url,  int? sig,  String? type)  $default,) {final _that = this;
switch (_that) {
case _UsgsProperties():
return $default(_that.mag,_that.place,_that.time,_that.alert,_that.status,_that.tsunami,_that.title,_that.url,_that.sig,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _asDouble)  double? mag,  String? place,  int? time,  String? alert,  String? status,  int? tsunami,  String? title,  String? url,  int? sig,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _UsgsProperties() when $default != null:
return $default(_that.mag,_that.place,_that.time,_that.alert,_that.status,_that.tsunami,_that.title,_that.url,_that.sig,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsgsProperties implements UsgsProperties {
  const _UsgsProperties({@JsonKey(fromJson: _asDouble) this.mag, this.place, this.time, this.alert, this.status, this.tsunami, this.title, this.url, this.sig, this.type});
  factory _UsgsProperties.fromJson(Map<String, dynamic> json) => _$UsgsPropertiesFromJson(json);

@override@JsonKey(fromJson: _asDouble) final  double? mag;
@override final  String? place;
@override final  int? time;
@override final  String? alert;
@override final  String? status;
@override final  int? tsunami;
@override final  String? title;
@override final  String? url;
@override final  int? sig;
@override final  String? type;

/// Create a copy of UsgsProperties
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsgsPropertiesCopyWith<_UsgsProperties> get copyWith => __$UsgsPropertiesCopyWithImpl<_UsgsProperties>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsgsPropertiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsgsProperties&&(identical(other.mag, mag) || other.mag == mag)&&(identical(other.place, place) || other.place == place)&&(identical(other.time, time) || other.time == time)&&(identical(other.alert, alert) || other.alert == alert)&&(identical(other.status, status) || other.status == status)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.sig, sig) || other.sig == sig)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mag,place,time,alert,status,tsunami,title,url,sig,type);

@override
String toString() {
  return 'UsgsProperties(mag: $mag, place: $place, time: $time, alert: $alert, status: $status, tsunami: $tsunami, title: $title, url: $url, sig: $sig, type: $type)';
}


}

/// @nodoc
abstract mixin class _$UsgsPropertiesCopyWith<$Res> implements $UsgsPropertiesCopyWith<$Res> {
  factory _$UsgsPropertiesCopyWith(_UsgsProperties value, $Res Function(_UsgsProperties) _then) = __$UsgsPropertiesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _asDouble) double? mag, String? place, int? time, String? alert, String? status, int? tsunami, String? title, String? url, int? sig, String? type
});




}
/// @nodoc
class __$UsgsPropertiesCopyWithImpl<$Res>
    implements _$UsgsPropertiesCopyWith<$Res> {
  __$UsgsPropertiesCopyWithImpl(this._self, this._then);

  final _UsgsProperties _self;
  final $Res Function(_UsgsProperties) _then;

/// Create a copy of UsgsProperties
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mag = freezed,Object? place = freezed,Object? time = freezed,Object? alert = freezed,Object? status = freezed,Object? tsunami = freezed,Object? title = freezed,Object? url = freezed,Object? sig = freezed,Object? type = freezed,}) {
  return _then(_UsgsProperties(
mag: freezed == mag ? _self.mag : mag // ignore: cast_nullable_to_non_nullable
as double?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int?,alert: freezed == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,tsunami: freezed == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,sig: freezed == sig ? _self.sig : sig // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UsgsGeometry {

@JsonKey(fromJson: _asCoordinates) List<double> get coordinates;
/// Create a copy of UsgsGeometry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsgsGeometryCopyWith<UsgsGeometry> get copyWith => _$UsgsGeometryCopyWithImpl<UsgsGeometry>(this as UsgsGeometry, _$identity);

  /// Serializes this UsgsGeometry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsgsGeometry&&const DeepCollectionEquality().equals(other.coordinates, coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(coordinates));

@override
String toString() {
  return 'UsgsGeometry(coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class $UsgsGeometryCopyWith<$Res>  {
  factory $UsgsGeometryCopyWith(UsgsGeometry value, $Res Function(UsgsGeometry) _then) = _$UsgsGeometryCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _asCoordinates) List<double> coordinates
});




}
/// @nodoc
class _$UsgsGeometryCopyWithImpl<$Res>
    implements $UsgsGeometryCopyWith<$Res> {
  _$UsgsGeometryCopyWithImpl(this._self, this._then);

  final UsgsGeometry _self;
  final $Res Function(UsgsGeometry) _then;

/// Create a copy of UsgsGeometry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coordinates = null,}) {
  return _then(_self.copyWith(
coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [UsgsGeometry].
extension UsgsGeometryPatterns on UsgsGeometry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsgsGeometry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsgsGeometry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsgsGeometry value)  $default,){
final _that = this;
switch (_that) {
case _UsgsGeometry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsgsGeometry value)?  $default,){
final _that = this;
switch (_that) {
case _UsgsGeometry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _asCoordinates)  List<double> coordinates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsgsGeometry() when $default != null:
return $default(_that.coordinates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _asCoordinates)  List<double> coordinates)  $default,) {final _that = this;
switch (_that) {
case _UsgsGeometry():
return $default(_that.coordinates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _asCoordinates)  List<double> coordinates)?  $default,) {final _that = this;
switch (_that) {
case _UsgsGeometry() when $default != null:
return $default(_that.coordinates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsgsGeometry implements UsgsGeometry {
  const _UsgsGeometry({@JsonKey(fromJson: _asCoordinates) final  List<double> coordinates = const <double>[]}): _coordinates = coordinates;
  factory _UsgsGeometry.fromJson(Map<String, dynamic> json) => _$UsgsGeometryFromJson(json);

 final  List<double> _coordinates;
@override@JsonKey(fromJson: _asCoordinates) List<double> get coordinates {
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coordinates);
}


/// Create a copy of UsgsGeometry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsgsGeometryCopyWith<_UsgsGeometry> get copyWith => __$UsgsGeometryCopyWithImpl<_UsgsGeometry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsgsGeometryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsgsGeometry&&const DeepCollectionEquality().equals(other._coordinates, _coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_coordinates));

@override
String toString() {
  return 'UsgsGeometry(coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class _$UsgsGeometryCopyWith<$Res> implements $UsgsGeometryCopyWith<$Res> {
  factory _$UsgsGeometryCopyWith(_UsgsGeometry value, $Res Function(_UsgsGeometry) _then) = __$UsgsGeometryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _asCoordinates) List<double> coordinates
});




}
/// @nodoc
class __$UsgsGeometryCopyWithImpl<$Res>
    implements _$UsgsGeometryCopyWith<$Res> {
  __$UsgsGeometryCopyWithImpl(this._self, this._then);

  final _UsgsGeometry _self;
  final $Res Function(_UsgsGeometry) _then;

/// Create a copy of UsgsGeometry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coordinates = null,}) {
  return _then(_UsgsGeometry(
coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on

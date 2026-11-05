// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_wizard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportWizardState {

 ReportDraft get draft; ReportWizardStep get step; bool get isSubmitting; bool get isLocating; bool get submitted; String? get errorMessage;
/// Create a copy of ReportWizardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportWizardStateCopyWith<ReportWizardState> get copyWith => _$ReportWizardStateCopyWithImpl<ReportWizardState>(this as ReportWizardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportWizardState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.step, step) || other.step == step)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLocating, isLocating) || other.isLocating == isLocating)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,draft,step,isSubmitting,isLocating,submitted,errorMessage);

@override
String toString() {
  return 'ReportWizardState(draft: $draft, step: $step, isSubmitting: $isSubmitting, isLocating: $isLocating, submitted: $submitted, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ReportWizardStateCopyWith<$Res>  {
  factory $ReportWizardStateCopyWith(ReportWizardState value, $Res Function(ReportWizardState) _then) = _$ReportWizardStateCopyWithImpl;
@useResult
$Res call({
 ReportDraft draft, ReportWizardStep step, bool isSubmitting, bool isLocating, bool submitted, String? errorMessage
});


$ReportDraftCopyWith<$Res> get draft;

}
/// @nodoc
class _$ReportWizardStateCopyWithImpl<$Res>
    implements $ReportWizardStateCopyWith<$Res> {
  _$ReportWizardStateCopyWithImpl(this._self, this._then);

  final ReportWizardState _self;
  final $Res Function(ReportWizardState) _then;

/// Create a copy of ReportWizardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,Object? step = null,Object? isSubmitting = null,Object? isLocating = null,Object? submitted = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ReportDraft,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ReportWizardStep,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLocating: null == isLocating ? _self.isLocating : isLocating // ignore: cast_nullable_to_non_nullable
as bool,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReportWizardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportDraftCopyWith<$Res> get draft {
  
  return $ReportDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportWizardState].
extension ReportWizardStatePatterns on ReportWizardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportWizardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportWizardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportWizardState value)  $default,){
final _that = this;
switch (_that) {
case _ReportWizardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportWizardState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportWizardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportDraft draft,  ReportWizardStep step,  bool isSubmitting,  bool isLocating,  bool submitted,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportWizardState() when $default != null:
return $default(_that.draft,_that.step,_that.isSubmitting,_that.isLocating,_that.submitted,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportDraft draft,  ReportWizardStep step,  bool isSubmitting,  bool isLocating,  bool submitted,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReportWizardState():
return $default(_that.draft,_that.step,_that.isSubmitting,_that.isLocating,_that.submitted,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportDraft draft,  ReportWizardStep step,  bool isSubmitting,  bool isLocating,  bool submitted,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReportWizardState() when $default != null:
return $default(_that.draft,_that.step,_that.isSubmitting,_that.isLocating,_that.submitted,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReportWizardState extends ReportWizardState {
  const _ReportWizardState({this.draft = const ReportDraft(), this.step = ReportWizardStep.category, this.isSubmitting = false, this.isLocating = false, this.submitted = false, this.errorMessage}): super._();
  

@override@JsonKey() final  ReportDraft draft;
@override@JsonKey() final  ReportWizardStep step;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isLocating;
@override@JsonKey() final  bool submitted;
@override final  String? errorMessage;

/// Create a copy of ReportWizardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportWizardStateCopyWith<_ReportWizardState> get copyWith => __$ReportWizardStateCopyWithImpl<_ReportWizardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportWizardState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.step, step) || other.step == step)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLocating, isLocating) || other.isLocating == isLocating)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,draft,step,isSubmitting,isLocating,submitted,errorMessage);

@override
String toString() {
  return 'ReportWizardState(draft: $draft, step: $step, isSubmitting: $isSubmitting, isLocating: $isLocating, submitted: $submitted, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReportWizardStateCopyWith<$Res> implements $ReportWizardStateCopyWith<$Res> {
  factory _$ReportWizardStateCopyWith(_ReportWizardState value, $Res Function(_ReportWizardState) _then) = __$ReportWizardStateCopyWithImpl;
@override @useResult
$Res call({
 ReportDraft draft, ReportWizardStep step, bool isSubmitting, bool isLocating, bool submitted, String? errorMessage
});


@override $ReportDraftCopyWith<$Res> get draft;

}
/// @nodoc
class __$ReportWizardStateCopyWithImpl<$Res>
    implements _$ReportWizardStateCopyWith<$Res> {
  __$ReportWizardStateCopyWithImpl(this._self, this._then);

  final _ReportWizardState _self;
  final $Res Function(_ReportWizardState) _then;

/// Create a copy of ReportWizardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? step = null,Object? isSubmitting = null,Object? isLocating = null,Object? submitted = null,Object? errorMessage = freezed,}) {
  return _then(_ReportWizardState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ReportDraft,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ReportWizardStep,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLocating: null == isLocating ? _self.isLocating : isLocating // ignore: cast_nullable_to_non_nullable
as bool,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReportWizardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportDraftCopyWith<$Res> get draft {
  
  return $ReportDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on

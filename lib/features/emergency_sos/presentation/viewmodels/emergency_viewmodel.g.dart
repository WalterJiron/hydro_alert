// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmergencyViewModel)
final emergencyViewModelProvider = EmergencyViewModelProvider._();

final class EmergencyViewModelProvider
    extends $NotifierProvider<EmergencyViewModel, EmergencyEvent?> {
  EmergencyViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyViewModelHash();

  @$internal
  @override
  EmergencyViewModel create() => EmergencyViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencyEvent? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencyEvent?>(value),
    );
  }
}

String _$emergencyViewModelHash() =>
    r'eef7eb4818f06b609b81c200c8922c5fb4f26a15';

abstract class _$EmergencyViewModel extends $Notifier<EmergencyEvent?> {
  EmergencyEvent? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EmergencyEvent?, EmergencyEvent?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmergencyEvent?, EmergencyEvent?>,
              EmergencyEvent?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapViewModel)
final mapViewModelProvider = MapViewModelProvider._();

final class MapViewModelProvider
    extends $NotifierProvider<MapViewModel, MapViewState> {
  MapViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapViewModelHash();

  @$internal
  @override
  MapViewModel create() => MapViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapViewState>(value),
    );
  }
}

String _$mapViewModelHash() => r'ad9676a6a39282666ef102607924240e1e3ba221';

abstract class _$MapViewModel extends $Notifier<MapViewState> {
  MapViewState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MapViewState, MapViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapViewState, MapViewState>,
              MapViewState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

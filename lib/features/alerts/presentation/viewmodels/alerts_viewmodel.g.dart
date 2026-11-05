// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AlertsViewModel)
final alertsViewModelProvider = AlertsViewModelProvider._();

final class AlertsViewModelProvider
    extends $AsyncNotifierProvider<AlertsViewModel, List<SeismicEvent>> {
  AlertsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alertsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alertsViewModelHash();

  @$internal
  @override
  AlertsViewModel create() => AlertsViewModel();
}

String _$alertsViewModelHash() => r'9797fceb572ec9f9076e5fa90cb2c89dd0ad17f3';

abstract class _$AlertsViewModel extends $AsyncNotifier<List<SeismicEvent>> {
  FutureOr<List<SeismicEvent>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SeismicEvent>>, List<SeismicEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SeismicEvent>>, List<SeismicEvent>>,
              AsyncValue<List<SeismicEvent>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

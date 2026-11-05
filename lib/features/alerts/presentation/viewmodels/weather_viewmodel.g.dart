// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WeatherViewModel)
final weatherViewModelProvider = WeatherViewModelProvider._();

final class WeatherViewModelProvider
    extends $AsyncNotifierProvider<WeatherViewModel, WeatherSnapshot> {
  WeatherViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherViewModelHash();

  @$internal
  @override
  WeatherViewModel create() => WeatherViewModel();
}

String _$weatherViewModelHash() => r'45de69b6ff0f329f72af7878a3305ab6548aa369';

abstract class _$WeatherViewModel extends $AsyncNotifier<WeatherSnapshot> {
  FutureOr<WeatherSnapshot> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WeatherSnapshot>, WeatherSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WeatherSnapshot>, WeatherSnapshot>,
              AsyncValue<WeatherSnapshot>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

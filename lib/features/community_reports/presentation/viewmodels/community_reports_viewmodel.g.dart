// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_reports_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommunityReportsViewModel)
final communityReportsViewModelProvider = CommunityReportsViewModelProvider._();

final class CommunityReportsViewModelProvider
    extends
        $AsyncNotifierProvider<
          CommunityReportsViewModel,
          List<CommunityReport>
        > {
  CommunityReportsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityReportsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityReportsViewModelHash();

  @$internal
  @override
  CommunityReportsViewModel create() => CommunityReportsViewModel();
}

String _$communityReportsViewModelHash() =>
    r'5df80df6c2b70510f42a278cbbfd0f6e7ab1e512';

abstract class _$CommunityReportsViewModel
    extends $AsyncNotifier<List<CommunityReport>> {
  FutureOr<List<CommunityReport>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CommunityReport>>, List<CommunityReport>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CommunityReport>>,
                List<CommunityReport>
              >,
              AsyncValue<List<CommunityReport>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

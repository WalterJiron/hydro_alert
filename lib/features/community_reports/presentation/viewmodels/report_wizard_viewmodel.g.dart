// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_wizard_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportWizardViewModel)
final reportWizardViewModelProvider = ReportWizardViewModelProvider._();

final class ReportWizardViewModelProvider
    extends $NotifierProvider<ReportWizardViewModel, ReportWizardState> {
  ReportWizardViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportWizardViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportWizardViewModelHash();

  @$internal
  @override
  ReportWizardViewModel create() => ReportWizardViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportWizardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportWizardState>(value),
    );
  }
}

String _$reportWizardViewModelHash() =>
    r'c73fdde8b747489f9cf0e21cc2673cc594d90dc6';

abstract class _$ReportWizardViewModel extends $Notifier<ReportWizardState> {
  ReportWizardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ReportWizardState, ReportWizardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReportWizardState, ReportWizardState>,
              ReportWizardState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

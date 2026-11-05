import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/report_draft.dart';

part 'report_wizard_state.freezed.dart';

enum ReportWizardStep { category, evidence }

@freezed
abstract class ReportWizardState with _$ReportWizardState {
  const factory ReportWizardState({
    @Default(ReportDraft()) ReportDraft draft,
    @Default(ReportWizardStep.category) ReportWizardStep step,
    @Default(false) bool isSubmitting,
    @Default(false) bool isLocating,
    @Default(false) bool submitted,
    String? errorMessage,
  }) = _ReportWizardState;

  const ReportWizardState._();

  bool get canContinue => draft.category != null;

  bool get canSubmit => draft.isValid && !isSubmitting;
}

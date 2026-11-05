import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/services/location_service.dart';
import '../../data/repositories/community_reports_repository_impl.dart';
import '../../domain/entities/report_category.dart';
import 'community_reports_viewmodel.dart';
import 'report_wizard_state.dart';

part 'report_wizard_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class ReportWizardViewModel extends _$ReportWizardViewModel {
  @override
  ReportWizardState build() => const ReportWizardState();

  void selectCategory(ReportCategory category) {
    state = state.copyWith(
      draft: state.draft.copyWith(category: category),
      errorMessage: null,
    );
  }

  void updateDescription(String description) {
    state = state.copyWith(
      draft: state.draft.copyWith(description: description),
      errorMessage: null,
    );
  }

  void setPhoto({required Uint8List bytes, required String name}) {
    state = state.copyWith(
      draft: state.draft.copyWith(photoBytes: bytes, photoName: name),
      errorMessage: null,
    );
  }

  void removePhoto() {
    state = state.copyWith(
      draft: state.draft.copyWith(photoBytes: null, photoName: null),
    );
  }

  void setLocation({required double latitude, required double longitude}) {
    state = state.copyWith(
      draft: state.draft.copyWith(latitude: latitude, longitude: longitude),
      errorMessage: null,
    );
  }

  Future<void> locateUser() async {
    if (state.isLocating) {
      return;
    }

    state = state.copyWith(isLocating: true, errorMessage: null);
    try {
      final position = await ref
          .read(locationServiceProvider)
          .getCurrentPosition();
      state = state.copyWith(
        isLocating: false,
        draft: state.draft.copyWith(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } on AppFailure catch (error) {
      state = state.copyWith(isLocating: false, errorMessage: error.message);
    } catch (_) {
      state = state.copyWith(
        isLocating: false,
        errorMessage: 'No pudimos obtener tu ubicación. Inténtalo de nuevo.',
      );
    }
  }

  void goToEvidence() {
    if (state.draft.category == null) {
      state = state.copyWith(
        errorMessage: 'Selecciona una categoría para continuar.',
      );
      return;
    }
    state = state.copyWith(step: ReportWizardStep.evidence, errorMessage: null);
  }

  void goBack() {
    state = state.copyWith(step: ReportWizardStep.category, errorMessage: null);
  }

  Future<void> submit() async {
    if (state.isSubmitting) {
      return;
    }

    if (!state.draft.isValid) {
      state = state.copyWith(
        errorMessage:
            'Completa la categoría, una descripción de al menos 10 caracteres y la ubicación.',
      );
      return;
    }

    if (!AppConfig.hasBackend) {
      state = state.copyWith(
        errorMessage:
            'El envío de reportes estará disponible cuando se configure el servicio.',
      );
      return;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await ref
          .read(communityReportsRepositoryProvider)
          .createReport(state.draft);
      if (!ref.mounted) {
        return;
      }
      state = state.copyWith(isSubmitting: false, submitted: true);
      await ref.read(communityReportsViewModelProvider.notifier).refresh();
    } on AppFailure catch (error) {
      if (!ref.mounted) {
        return;
      }
      state = state.copyWith(isSubmitting: false, errorMessage: error.message);
    } catch (_) {
      if (!ref.mounted) {
        return;
      }
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'No pudimos enviar el reporte. Inténtalo de nuevo.',
      );
    }
  }

  void reset() {
    state = const ReportWizardState();
  }

  void clearError() {
    if (state.errorMessage == null) {
      return;
    }
    state = state.copyWith(errorMessage: null);
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../viewmodels/report_wizard_state.dart';
import 'report_location_card.dart';
import 'report_photo_section.dart';
import 'report_requirements_card.dart';

/// Second wizard step: location, optional photo and submit checklist.
class ReportEvidenceStep extends StatelessWidget {
  const ReportEvidenceStep({
    super.key,
    required this.state,
    required this.photoError,
    required this.onLocate,
    required this.onPickCamera,
    required this.onPickGallery,
    required this.onRemovePhoto,
    required this.onBack,
    required this.onSubmit,
  });

  final ReportWizardState state;
  final String? photoError;
  final VoidCallback onLocate;
  final VoidCallback onPickCamera;
  final VoidCallback onPickGallery;
  final VoidCallback onRemovePhoto;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReportLocationCard(
          draft: state.draft,
          isLocating: state.isLocating,
          onLocate: onLocate,
        ),
        const SizedBox(height: 22),
        ReportPhotoSection(
          draft: state.draft,
          errorMessage: photoError,
          onPickCamera: onPickCamera,
          onPickGallery: onPickGallery,
          onRemove: onRemovePhoto,
        ),
        const SizedBox(height: 22),
        ReportRequirementsCard(draft: state.draft),
        if (state.errorMessage != null) ...[
          const SizedBox(height: 14),
          InfoBanner(
            icon: LucideIcons.circleAlert,
            tone: InfoBannerTone.danger,
            message: state.errorMessage!,
          ),
        ],
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                label: 'Atrás',
                icon: LucideIcons.arrowLeft,
                variant: AppButtonVariant.secondary,
                onPressed: state.isSubmitting ? null : onBack,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: CustomButton(
                label: 'Enviar reporte',
                icon: LucideIcons.send,
                isLoading: state.isSubmitting,
                onPressed: state.canSubmit ? onSubmit : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Al enviar, aceptas que el reporte se muestre como información comunitaria no verificada.',
          style: AppTypography.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

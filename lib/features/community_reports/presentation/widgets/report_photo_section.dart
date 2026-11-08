import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../domain/entities/report_draft.dart';

/// Optional photo section of the evidence step.
class ReportPhotoSection extends StatelessWidget {
  const ReportPhotoSection({
    super.key,
    required this.draft,
    required this.errorMessage,
    required this.onPickCamera,
    required this.onPickGallery,
    required this.onRemove,
  });

  final ReportDraft draft;
  final String? errorMessage;
  final VoidCallback onPickCamera;
  final VoidCallback onPickGallery;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Foto', style: AppTypography.titleLarge),
            const SizedBox(width: 8),
            Text('(opcional)', style: AppTypography.bodySmall),
          ],
        ),
        const SizedBox(height: 4),
        Text('JPG, PNG o WebP · máximo 5 MB.', style: AppTypography.bodySmall),
        const SizedBox(height: 10),
        if (draft.photoBytes == null)
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  label: 'Cámara',
                  icon: LucideIcons.camera,
                  variant: AppButtonVariant.secondary,
                  onPressed: onPickCamera,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  label: 'Galería',
                  icon: LucideIcons.image,
                  variant: AppButtonVariant.secondary,
                  onPressed: onPickGallery,
                ),
              ),
            ],
          )
        else
          AppCard(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    draft.photoBytes!,
                    height: 180,
                    fit: BoxFit.cover,
                    semanticLabel: 'Foto adjunta al reporte',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        draft.photoName ?? 'Foto adjunta',
                        style: AppTypography.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: onRemove,
                      icon: const Icon(LucideIcons.trash2, size: 16),
                      label: const Text('Quitar'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.danger,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (errorMessage != null) ...[
          const SizedBox(height: 10),
          InfoBanner(
            icon: LucideIcons.circleAlert,
            tone: InfoBannerTone.danger,
            message: errorMessage!,
          ),
        ],
      ],
    );
  }
}

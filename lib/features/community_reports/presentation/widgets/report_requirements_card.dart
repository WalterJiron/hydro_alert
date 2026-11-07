import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../domain/entities/report_draft.dart';

/// Checklist that shows which requirements are already satisfied before
/// submitting the report.
class ReportRequirementsCard extends StatelessWidget {
  const ReportRequirementsCard({super.key, required this.draft});

  final ReportDraft draft;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Antes de enviar', style: AppTypography.titleLarge),
        const SizedBox(height: 10),
        AppCard(
          child: Column(
            children: [
              _Requirement(
                label: 'Categoría seleccionada',
                met: draft.category != null,
              ),
              const SizedBox(height: 8),
              _Requirement(
                label: 'Descripción de al menos 10 caracteres',
                met: draft.description.trim().length >= 10,
              ),
              const SizedBox(height: 8),
              _Requirement(
                label: 'Ubicación del reporte',
                met: draft.hasLocation,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Requirement extends StatelessWidget {
  const _Requirement({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          met ? LucideIcons.circleCheck : LucideIcons.circleAlert,
          size: 18,
          color: met ? AppColors.success : AppColors.textMuted,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: met ? AppColors.textSecondary : AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../viewmodels/report_wizard_state.dart';

/// Two-step progress indicator shown in the wizard app bar.
class ReportWizardStepBar extends StatelessWidget {
  const ReportWizardStepBar({super.key, required this.step});

  final ReportWizardStep step;

  @override
  Widget build(BuildContext context) {
    final onEvidence = step == ReportWizardStep.evidence;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          _StepSegment(
            number: 1,
            label: 'Categoría',
            isActive: !onEvidence,
            isComplete: onEvidence,
          ),
          const SizedBox(width: 8),
          _StepSegment(
            number: 2,
            label: 'Detalles',
            isActive: onEvidence,
            isComplete: false,
          ),
        ],
      ),
    );
  }
}

class _StepSegment extends StatelessWidget {
  const _StepSegment({
    required this.number,
    required this.label,
    required this.isActive,
    required this.isComplete,
  });

  final int number;
  final String label;
  final bool isActive;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final background = isActive || isComplete
        ? AppColors.primary
        : AppColors.surfaceMuted;
    final foreground = isActive || isComplete
        ? Colors.white
        : AppColors.textMuted;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySoft : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: isComplete
                  ? const Icon(LucideIcons.check, size: 12, color: Colors.white)
                  : Text(
                      '$number',
                      style: AppTypography.labelSmall.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  color: isActive ? AppColors.primary : AppColors.textMuted,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

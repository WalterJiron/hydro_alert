import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../domain/entities/report_category.dart';
import '../viewmodels/report_wizard_state.dart';
import 'report_category_visuals.dart';

/// First wizard step: category picker and free-text description.
class ReportCategoryStep extends StatelessWidget {
  const ReportCategoryStep({
    super.key,
    required this.state,
    required this.descriptionController,
    required this.onSelectCategory,
    required this.onDescriptionChanged,
    required this.onContinue,
  });

  final ReportWizardState state;
  final TextEditingController descriptionController;
  final ValueChanged<ReportCategory> onSelectCategory;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const InfoBanner(
          icon: LucideIcons.shieldAlert,
          tone: InfoBannerTone.warning,
          title: 'Reporte comunitario',
          message:
              'Tu reporte será visible como información no verificada. No incluyas '
              'datos personales ni información sensible.',
        ),
        const SizedBox(height: 20),
        Text('¿Qué observas?', style: AppTypography.titleLarge),
        const SizedBox(height: 4),
        Text(
          'Selecciona la categoría que mejor describa la situación.',
          style: AppTypography.bodySmall,
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ReportCategory.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 96,
          ),
          itemBuilder: (context, index) {
            final category = ReportCategory.values[index];
            return _CategoryOption(
              category: category,
              selected: state.draft.category == category,
              onTap: () => onSelectCategory(category),
            );
          },
        ),
        const SizedBox(height: 20),
        Text('Descripción', style: AppTypography.titleSmall),
        const SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          maxLines: 4,
          maxLength: 500,
          textCapitalization: TextCapitalization.sentences,
          onChanged: onDescriptionChanged,
          decoration: const InputDecoration(
            hintText:
                'Describe lo que ves: lugar, condiciones y cualquier riesgo inmediato.',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Mínimo 10 caracteres. Sé breve y claro.',
          style: AppTypography.bodySmall,
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: 14),
          InfoBanner(
            icon: LucideIcons.circleAlert,
            tone: InfoBannerTone.danger,
            message: state.errorMessage!,
          ),
        ],
        const SizedBox(height: 20),
        CustomButton(
          label: 'Continuar',
          icon: LucideIcons.arrowRight,
          expand: true,
          onPressed: state.canContinue ? onContinue : null,
        ),
      ],
    );
  }
}

class _CategoryOption extends StatelessWidget {
  const _CategoryOption({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final ReportCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = reportCategoryColor(category);

    return Material(
      color: selected ? AppColors.primarySoft : AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  reportCategoryIcon(category),
                  size: 18,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.label,
                  style: AppTypography.labelMedium.copyWith(
                    color: selected
                        ? AppColors.primaryDark
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected)
                const Icon(
                  LucideIcons.check,
                  size: 16,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

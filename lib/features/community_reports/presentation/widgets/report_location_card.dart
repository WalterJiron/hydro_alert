import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../domain/entities/report_draft.dart';

/// Evidence step section that requests the report coordinates.
class ReportLocationCard extends StatelessWidget {
  const ReportLocationCard({
    super.key,
    required this.draft,
    required this.isLocating,
    required this.onLocate,
  });

  final ReportDraft draft;
  final bool isLocating;
  final VoidCallback onLocate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Ubicación', style: AppTypography.titleLarge),
        const SizedBox(height: 4),
        Text(
          'Necesitamos la ubicación del reporte. Se solicita solo cuando la pides.',
          style: AppTypography.bodySmall,
        ),
        const SizedBox(height: 10),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: draft.hasLocation
                          ? AppColors.successSoft
                          : AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      LucideIcons.mapPin,
                      size: 20,
                      color: draft.hasLocation
                          ? AppColors.success
                          : AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          draft.hasLocation
                              ? 'Ubicación seleccionada'
                              : 'Ubicación pendiente',
                          style: AppTypography.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          draft.hasLocation
                              ? '${draft.latitude!.toStringAsFixed(5)}, '
                                    '${draft.longitude!.toStringAsFixed(5)}'
                              : 'Activa la ubicación para continuar.',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomButton(
                label: draft.hasLocation
                    ? 'Actualizar ubicación'
                    : 'Usar mi ubicación',
                icon: LucideIcons.locateFixed,
                expand: true,
                variant: AppButtonVariant.secondary,
                isLoading: isLocating,
                onPressed: isLocating ? null : onLocate,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

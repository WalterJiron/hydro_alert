import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/molecules/app_card.dart';

/// Call to action that opens the community report wizard.
class CommunityReportCta extends StatelessWidget {
  const CommunityReportCta({
    super.key,
    required this.enabled,
    required this.onTap,
  });

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return AppCard(
      backgroundColor: palette.primarySoft,
      borderColor: palette.primary.withValues(alpha: 0.18),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: palette.primaryFill,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              LucideIcons.plus,
              color: palette.onPrimaryFill,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Viste una situación de riesgo?',
                  style: AppTypography.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  enabled
                      ? 'Comparte una foto, una descripción y la ubicación.'
                      : 'El servicio de reportes no está configurado todavía.',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: enabled ? onTap : null,
            tooltip: 'Crear reporte',
            style: IconButton.styleFrom(
              backgroundColor: enabled ? palette.primaryFill : palette.surface,
              foregroundColor: enabled
                  ? palette.onPrimaryFill
                  : palette.textMuted,
            ),
            icon: const Icon(LucideIcons.arrowRight, size: 20),
          ),
        ],
      ),
    );
  }
}

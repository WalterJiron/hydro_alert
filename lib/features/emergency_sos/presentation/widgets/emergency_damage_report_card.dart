import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/app_card.dart';

/// Entry point to the community damage report wizard.
class EmergencyDamageReportCard extends StatelessWidget {
  const EmergencyDamageReportCard({super.key, required this.onCreateReport});

  final VoidCallback onCreateReport;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Si es seguro hacerlo, documenta la situación. Tu reporte se '
            'mostrará como información comunitaria no verificada.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 12),
          CustomButton(
            label: AppConfig.hasBackend
                ? 'Crear reporte de daños'
                : 'Reportes no configurados',
            icon: LucideIcons.clipboardList,
            expand: true,
            variant: AppButtonVariant.secondary,
            onPressed: AppConfig.hasBackend ? onCreateReport : null,
          ),
        ],
      ),
    );
  }
}

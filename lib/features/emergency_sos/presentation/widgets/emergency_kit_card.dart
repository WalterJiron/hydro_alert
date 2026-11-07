import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/molecules/app_card.dart';

/// Compact list of the items recommended for an emergency kit.
class EmergencyKitCard extends StatelessWidget {
  const EmergencyKitCard({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (LucideIcons.droplets, 'Agua'),
      (LucideIcons.briefcaseMedical, 'Botiquín'),
      (LucideIcons.flashlight, 'Linterna'),
      (LucideIcons.radio, 'Radio'),
      (LucideIcons.fileText, 'Documentos'),
      (LucideIcons.batteryCharging, 'Batería'),
    ];

    return AppCard(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final item in items)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.$1, size: 15, color: AppColors.textSecondary),
                  const SizedBox(width: 5),
                  Text(item.$2, style: AppTypography.labelSmall),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

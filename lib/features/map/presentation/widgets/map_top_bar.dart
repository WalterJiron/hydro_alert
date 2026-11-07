import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/status_indicator.dart';

/// Floating header of the map with the app identity, the USGS status and the
/// entry point to the legend.
class MapTopBar extends StatelessWidget {
  const MapTopBar({
    super.key,
    required this.alertsLoading,
    required this.alertsAvailable,
    required this.onOpenLegend,
  });

  final bool alertsLoading;
  final bool alertsAvailable;
  final VoidCallback onOpenLegend;

  @override
  Widget build(BuildContext context) {
    final statusLabel = alertsLoading
        ? 'USGS actualizando'
        : (alertsAvailable ? 'USGS' : 'USGS no disponible');

    return Material(
      color: AppColors.mapPanel,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const AppLogo(size: 22),
            const SizedBox(width: 8),
            Text('Nicaragua', style: AppTypography.titleSmall),
            const SizedBox(width: 12),
            StatusIndicator(
              label: statusLabel,
              color: alertsAvailable ? AppColors.info : AppColors.warning,
              isActive: alertsAvailable,
            ),
            const Spacer(),
            IconButton(
              onPressed: onOpenLegend,
              tooltip: 'Leyenda del mapa',
              icon: const Icon(LucideIcons.info, size: 19),
              color: AppColors.textSecondary,
              style: IconButton.styleFrom(
                minimumSize: const Size(40, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// RainViewer credit shown only while the radar layer is visible.
///
/// The Google Maps logo is provided by the map itself.
class MapRadarAttribution extends StatelessWidget {
  const MapRadarAttribution({super.key, required this.onRainViewer});

  final VoidCallback onRainViewer;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.mapPanel.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: InkWell(
          onTap: onRainViewer,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'RainViewer',
              style: AppTypography.labelSmall.copyWith(
                fontSize: 10,
                color: AppColors.textSecondary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.textMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

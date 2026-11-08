import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/motion/app_motion.dart';
import '../../domain/entities/radar_frame.dart';

/// RainViewer credit and the timestamp of the radar frame on screen.
///
/// The Mapbox logo and attribution are drawn by the map itself.
class MapRadarAttribution extends StatelessWidget {
  const MapRadarAttribution({
    super.key,
    required this.onRainViewer,
    this.frame,
  });

  final VoidCallback onRainViewer;
  final RadarFrame? frame;

  @override
  Widget build(BuildContext context) {
    final time = frame == null
        ? null
        : DateFormat.Hm('es').format(frame!.observedAt);

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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RainViewer',
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.textMuted,
                  ),
                ),
                if (time != null) ...[
                  Text(
                    ' · ',
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: AppMotion.resolve(context, AppMotion.quick),
                    switchInCurve: AppMotion.curve,
                    child: Text(
                      time,
                      key: ValueKey<String>(time),
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

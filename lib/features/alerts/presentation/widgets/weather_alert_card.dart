import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../domain/entities/weather_alert.dart';

/// Card for a single OpenWeatherMap alert.
class WeatherAlertCard extends StatelessWidget {
  const WeatherAlertCard({super.key, required this.alert});

  final WeatherAlert alert;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: alert.isActive
          ? AppColors.warningSoft
          : AppColors.surface,
      borderColor: alert.isActive
          ? AppColors.warning.withValues(alpha: 0.3)
          : AppColors.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                LucideIcons.cloudLightning,
                size: 22,
                color: AppColors.warningDark,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert.event, style: AppTypography.titleSmall),
                    const SizedBox(height: 2),
                    Text(alert.senderName, style: AppTypography.bodySmall),
                  ],
                ),
              ),
              AlertBadge(
                label: alert.isActive ? 'Activo' : 'Finalizado',
                tone: alert.isActive
                    ? AppBadgeTone.warning
                    : AppBadgeTone.neutral,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                LucideIcons.clock,
                size: 14,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${DateFormatter.shortDateTime(alert.start)} — '
                  '${DateFormatter.shortDateTime(alert.end)}',
                  style: AppTypography.bodySmall,
                ),
              ),
            ],
          ),
          if (alert.description.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              alert.description,
              style: AppTypography.bodyMedium,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

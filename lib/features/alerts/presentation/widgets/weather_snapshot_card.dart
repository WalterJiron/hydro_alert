import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../domain/entities/weather_snapshot.dart';
import 'weather_visuals.dart';

class WeatherSnapshotCard extends StatelessWidget {
  const WeatherSnapshotCard({super.key, required this.snapshot});

  final WeatherSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final color = weatherColorFor(snapshot.weatherMain);
    final activeAlerts = snapshot.alerts
        .where((alert) => alert.isActive)
        .toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  weatherIconFor(snapshot.weatherMain, snapshot.iconCode),
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${snapshot.temperatureC.round()}°C',
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 30,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      snapshot.condition,
                      style: AppTypography.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AlertBadge(
                label: 'OpenWeather',
                tone: AppBadgeTone.info,
                icon: LucideIcons.cloudSun,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 16,
            runSpacing: 10,
            children: [
              _Metric(
                icon: LucideIcons.thermometer,
                label: 'Sensación ${snapshot.feelsLikeC.round()}°C',
              ),
              _Metric(
                icon: LucideIcons.droplets,
                label: 'Humedad ${snapshot.humidity}%',
              ),
              _Metric(icon: LucideIcons.cloudRain, label: snapshot.rainLabel),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Actualizado ${DateFormatter.relative(snapshot.observedAt)}',
            style: AppTypography.labelSmall,
          ),
          if (activeAlerts.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warningSoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    LucideIcons.triangleAlert,
                    size: 18,
                    color: AppColors.warningDark,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activeAlerts.first.event,
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.warningDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${activeAlerts.first.senderName} · '
                          '${DateFormatter.shortDateTime(activeAlerts.first.start)}',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.warningDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.textMuted),
        const SizedBox(width: 5),
        Text(label, style: AppTypography.bodySmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/status_indicator.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/motion/app_animated_text.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../alerts/domain/entities/weather_snapshot.dart';

/// Quick counts of the three main data sources shown at the top of the home.
class HomeStatusSummary extends StatelessWidget {
  const HomeStatusSummary({
    super.key,
    required this.alerts,
    required this.weather,
    required this.reportCount,
  });

  final List<SeismicEvent>? alerts;
  final WeatherSnapshot? weather;
  final int? reportCount;

  @override
  Widget build(BuildContext context) {
    final seismicCount = alerts?.length ?? 0;
    final palette = context.palette;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.activity, size: 18, color: palette.primary),
              const SizedBox(width: 8),
              Text('Resumen de hoy', style: AppTypography.titleSmall),
              const Spacer(),
              StatusIndicator(
                label: alerts == null
                    ? 'Actualizando'
                    : (alerts!.isEmpty ? 'INETER' : alerts!.first.source),
                color: AppColors.info,
                isActive: alerts != null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: alerts == null ? '—' : '$seismicCount',
                  label: 'Sismos',
                  hint: '30 días',
                  color: AppColors.info,
                ),
              ),
              Container(width: 1, height: 46, color: palette.border),
              Expanded(
                child: _Stat(
                  value: reportCount == null ? '—' : '$reportCount',
                  label: 'Reportes',
                  hint: 'activos',
                  color: AppColors.warning,
                ),
              ),
              Container(width: 1, height: 46, color: palette.border),
              Expanded(
                child: _Stat(
                  value: weather == null
                      ? '—'
                      : '${weather!.temperatureC.round()}°',
                  label: 'Temperatura',
                  hint: weather == null ? 'sin datos' : 'Managua',
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.value,
    required this.label,
    required this.hint,
    required this.color,
  });

  final String value;
  final String label;
  final String hint;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppAnimatedText(
          text: value,
          style: AppTypography.headlineMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: context.palette.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        AppAnimatedText(text: hint, style: AppTypography.labelSmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../domain/entities/seismic_event.dart';
import 'seismic_visuals.dart';

class SeismicEventCard extends StatelessWidget {
  const SeismicEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.showDetails = false,
  });

  final SeismicEvent event;
  final VoidCallback? onTap;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    final magnitudeColor = seismicColorFor(event.magnitude);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: magnitudeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event.magnitudeLabel,
                      style: AppTypography.titleMedium.copyWith(
                        color: magnitudeColor,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'M',
                      style: AppTypography.labelSmall.copyWith(
                        color: magnitudeColor,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.place,
                      style: AppTypography.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.clock,
                          size: 13,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            DateFormatter.relative(event.occurredAt),
                            style: AppTypography.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AlertBadge(
                label: seismicLevelLabel(event.magnitude),
                tone: event.magnitude >= 5.0
                    ? AppBadgeTone.danger
                    : AppBadgeTone.seismic,
              ),
            ],
          ),
          if (showDetails) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Detail(icon: LucideIcons.layers, label: event.depthLabel),
                _Detail(
                  icon: LucideIcons.activity,
                  label: reviewStatusLabel(event.reviewStatus),
                ),
                if (event.tsunami)
                  const _Detail(
                    icon: LucideIcons.waves,
                    label: 'Aviso de tsunami',
                    isWarning: true,
                  ),
                const _Detail(icon: LucideIcons.radio, label: 'Fuente: USGS'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({
    required this.icon,
    required this.label,
    this.isWarning = false,
  });

  final IconData icon;
  final String label;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final color = isWarning ? AppColors.danger : AppColors.textMuted;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.bodySmall.copyWith(color: color)),
      ],
    );
  }
}

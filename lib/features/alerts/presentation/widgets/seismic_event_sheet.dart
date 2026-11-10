import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/external_link.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../domain/entities/seismic_event.dart';
import 'seismic_visuals.dart';

/// Shared event detail sheet used by the alerts list and the map.
Future<void> showSeismicEventSheet(BuildContext context, SeismicEvent event) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AlertBadge(
                    label: 'M ${event.magnitudeLabel}',
                    tone: AppBadgeTone.seismic,
                  ),
                  const SizedBox(width: 8),
                  AlertBadge(
                    label: seismicLevelLabel(event.magnitude),
                    tone: AppBadgeTone.warning,
                  ),
                  const Spacer(),
                  if (event.tsunami)
                    const AlertBadge(
                      label: 'Tsunami',
                      tone: AppBadgeTone.danger,
                      icon: LucideIcons.waves,
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Text(event.place, style: AppTypography.headlineSmall),
              const SizedBox(height: 6),
              Text(
                DateFormatter.dateTime(event.occurredAt),
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 16),
              _SheetRow(
                icon: LucideIcons.layers,
                label: 'Profundidad',
                value: event.depthKm == null
                    ? 'No disponible'
                    : '${event.depthKm!.toStringAsFixed(1)} km',
              ),
              _SheetRow(
                icon: LucideIcons.activity,
                label: 'Estado',
                value: reviewStatusLabel(event),
              ),
              _SheetRow(
                icon: LucideIcons.mapPin,
                label: 'Coordenadas',
                value: DateFormatter.coordinates(
                  event.latitude,
                  event.longitude,
                ),
              ),
              _SheetRow(
                icon: LucideIcons.radio,
                label: 'Fuente',
                value: event.source,
              ),
              const SizedBox(height: 16),
              const InfoBanner(
                icon: LucideIcons.info,
                message:
                    'Este registro no constituye una alerta oficial de evacuación.',
              ),
              const SizedBox(height: 16),
              if (event.url != null)
                CustomButton(
                  label: 'Abrir en ${event.source}',
                  icon: LucideIcons.externalLink,
                  expand: true,
                  onPressed: () async {
                    final launched = await openExternalUrl(event.url!);
                    if (!launched && sheetContext.mounted) {
                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                        SnackBar(
                          content: Text(
                            'No pudimos abrir el enlace de ${event.source}.',
                          ),
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}

class _SheetRow extends StatelessWidget {
  const _SheetRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 16, color: context.palette.textMuted),
          const SizedBox(width: 8),
          SizedBox(
            width: 92,
            child: Text(label, style: AppTypography.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.titleSmall,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

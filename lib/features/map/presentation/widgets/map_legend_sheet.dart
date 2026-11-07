import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/external_link.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../community_reports/domain/entities/report_category.dart';
import '../../../community_reports/presentation/widgets/report_category_visuals.dart';
import '../../../alerts/presentation/widgets/seismic_visuals.dart';

Future<void> showMapLegendSheet(
  BuildContext context, {
  required bool reportsAvailable,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Leyenda del mapa', style: AppTypography.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Qué representa cada símbolo y color.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 18),
              const _SectionTitle(
                icon: LucideIcons.activity,
                label: 'Sismos (USGS)',
              ),
              const SizedBox(height: 8),
              for (final magnitude in const [3.2, 4.5, 5.4, 6.2])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: seismicColorFor(magnitude),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${seismicLevelLabel(magnitude)} · '
                        '${_magnitudeRange(magnitude)}',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              Text(
                'El pin crece con la magnitud y muestra el valor dentro.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 18),
              const _SectionTitle(
                icon: LucideIcons.clipboardList,
                label: 'Reportes comunitarios',
              ),
              const SizedBox(height: 8),
              if (reportsAvailable) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final category in ReportCategory.values)
                      _CategoryChip(category: category),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Todos los reportes se muestran como sin verificar.',
                  style: AppTypography.bodySmall,
                ),
              ] else
                const InfoBanner(
                  icon: LucideIcons.plugZap,
                  tone: InfoBannerTone.info,
                  message:
                      'El servicio de reportes no está configurado en esta '
                      'compilación.',
                ),
              const SizedBox(height: 18),
              const _SectionTitle(icon: LucideIcons.radar, label: 'Radar'),
              const SizedBox(height: 6),
              Text(
                'Precipitación estimada de RainViewer. La capa llega hasta '
                'zoom 7; al acercarte se amplía la última imagen disponible.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 6),
              Text('Mapa base: Google Maps.', style: AppTypography.bodySmall),
              const SizedBox(height: 18),
              const InfoBanner(
                icon: LucideIcons.shieldAlert,
                tone: InfoBannerTone.warning,
                message:
                    'Los eventos de USGS no son alertas oficiales de '
                    'evacuación. Sigue siempre las indicaciones de las '
                    'autoridades.',
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 14,
                runSpacing: 4,
                children: [
                  _AttributionLink(
                    label: '© Google Maps',
                    url: ApiEndpoints.googleMapsSite,
                  ),
                  _AttributionLink(
                    label: 'RainViewer',
                    url: ApiEndpoints.rainViewerSite,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

String _magnitudeRange(double magnitude) {
  if (magnitude >= 6.0) {
    return '≥ 6.0';
  }
  if (magnitude >= 5.0) {
    return '5.0 – 5.9';
  }
  if (magnitude >= 4.0) {
    return '4.0 – 4.9';
  }
  return '< 4.0';
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Text(label, style: AppTypography.titleSmall),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final ReportCategory category;

  @override
  Widget build(BuildContext context) {
    final color = reportCategoryColor(category);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(reportCategoryIcon(category), size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            category.label,
            style: AppTypography.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _AttributionLink extends StatelessWidget {
  const _AttributionLink({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await openExternalUrl(url);
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

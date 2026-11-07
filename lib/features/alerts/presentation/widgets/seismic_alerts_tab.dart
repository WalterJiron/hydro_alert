import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../viewmodels/alerts_viewmodel.dart';
import '../widgets/seismic_event_card.dart';
import '../widgets/seismic_event_sheet.dart';

/// USGS earthquakes tab of the alerts screen.
class SeismicAlertsTab extends ConsumerWidget {
  const SeismicAlertsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsViewModelProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(alertsViewModelProvider.notifier).refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          const InfoBanner(
            icon: LucideIcons.shieldAlert,
            tone: InfoBannerTone.warning,
            title: 'Eventos de USGS',
            message:
                'Son registros sísmicos públicos, no alertas oficiales de evacuación. '
                'Sigue las indicaciones de SINAPRED y las autoridades locales.',
          ),
          const SizedBox(height: 16),
          ...alerts.when(
            loading: () => const [
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: LoadingState(message: 'Consultando sismos recientes…'),
              ),
            ],
            error: (error, stackTrace) => [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ErrorState(
                  message: errorMessageOf(error),
                  onRetry: () =>
                      ref.read(alertsViewModelProvider.notifier).refresh(),
                ),
              ),
            ],
            data: (events) {
              if (events.isEmpty) {
                return const [
                  Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: EmptyState(
                      icon: LucideIcons.activity,
                      title: 'Sin sismos recientes',
                      message:
                          'USGS no reporta eventos de magnitud 2.5 o superior en el área de Nicaragua durante los últimos 30 días.',
                    ),
                  ),
                ];
              }

              return [
                Row(
                  children: [
                    Text(
                      '${events.length} eventos',
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(width: 8),
                    const AlertBadge(
                      label: 'USGS',
                      tone: AppBadgeTone.info,
                      icon: LucideIcons.activity,
                    ),
                    const Spacer(),
                    Text('Últimos 30 días', style: AppTypography.labelSmall),
                  ],
                ),
                const SizedBox(height: 10),
                for (var index = 0; index < events.length; index++) ...[
                  if (index > 0) const SizedBox(height: 10),
                  SeismicEventCard(
                    event: events[index],
                    showDetails: true,
                    onTap: () => showSeismicEventSheet(context, events[index]),
                  ),
                ],
              ];
            },
          ),
        ],
      ),
    );
  }
}

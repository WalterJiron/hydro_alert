import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../domain/entities/seismic_event.dart';
import '../../domain/entities/weather_alert.dart';
import '../../domain/entities/weather_snapshot.dart';
import '../viewmodels/alerts_viewmodel.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/seismic_event_card.dart';
import '../widgets/seismic_event_sheet.dart';
import '../widgets/weather_snapshot_card.dart';

class AlertsListView extends StatelessWidget {
  const AlertsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alertas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sismos'),
              Tab(text: 'Clima'),
            ],
          ),
        ),
        body: const TabBarView(children: [_SeismicTab(), _WeatherTab()]),
      ),
    );
  }
}

class _SeismicTab extends ConsumerWidget {
  const _SeismicTab();

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
                    onTap: () => _showEventSheet(context, events[index]),
                  ),
                ],
              ];
            },
          ),
        ],
      ),
    );
  }

  void _showEventSheet(BuildContext context, SeismicEvent event) {
    showSeismicEventSheet(context, event);
  }
}

class _WeatherTab extends ConsumerWidget {
  const _WeatherTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherViewModelProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(weatherViewModelProvider.notifier).refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          if (!AppConfig.hasWeather)
            const InfoBanner(
              icon: LucideIcons.cloudSun,
              title: 'Clima no configurado',
              message:
                  'La información meteorológica se activará cuando se configure '
                  'la clave de OpenWeatherMap en esta compilación.',
            )
          else
            const InfoBanner(
              icon: LucideIcons.info,
              message:
                  'Los avisos meteorológicos provienen de OpenWeatherMap y no '
                  'sustituyen la información oficial de SINAPRED o INETER.',
            ),
          const SizedBox(height: 16),
          if (!AppConfig.hasWeather)
            const EmptyState(
              icon: LucideIcons.cloudSun,
              title: 'Información no disponible',
              message:
                  'Configura OpenWeatherMap para consultar el clima y sus avisos.',
            )
          else
            ...weather.when(
              loading: () => const [
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: LoadingState(message: 'Consultando el clima…'),
                ),
              ],
              error: (error, stackTrace) {
                if (error is ConfigurationFailure) {
                  return const [
                    EmptyState(
                      icon: LucideIcons.cloudSun,
                      title: 'Información no disponible',
                      message:
                          'Configura OpenWeatherMap para consultar el clima y sus avisos.',
                    ),
                  ];
                }
                return [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: ErrorState(
                      message: errorMessageOf(error),
                      onRetry: () =>
                          ref.read(weatherViewModelProvider.notifier).refresh(),
                    ),
                  ),
                ];
              },
              data: (snapshot) => _weatherContent(snapshot),
            ),
        ],
      ),
    );
  }

  List<Widget> _weatherContent(WeatherSnapshot snapshot) {
    final alerts = [...snapshot.alerts]
      ..sort((a, b) => b.start.compareTo(a.start));

    return [
      WeatherSnapshotCard(snapshot: snapshot),
      const SizedBox(height: 20),
      Row(
        children: [
          Text('Avisos meteorológicos', style: AppTypography.titleSmall),
          const Spacer(),
          AlertBadge(
            label: '${alerts.where((alert) => alert.isActive).length} activos',
            tone: alerts.any((alert) => alert.isActive)
                ? AppBadgeTone.warning
                : AppBadgeTone.neutral,
          ),
        ],
      ),
      const SizedBox(height: 10),
      if (alerts.isEmpty)
        const AppCard(
          child: EmptyState(
            icon: LucideIcons.cloudSun,
            title: 'Sin avisos activos',
            message:
                'OpenWeatherMap no reporta avisos meteorológicos para esta ubicación.',
          ),
        )
      else
        for (var index = 0; index < alerts.length; index++) ...[
          if (index > 0) const SizedBox(height: 10),
          _WeatherAlertCard(alert: alerts[index]),
        ],
    ];
  }
}

class _WeatherAlertCard extends StatelessWidget {
  const _WeatherAlertCard({required this.alert});

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

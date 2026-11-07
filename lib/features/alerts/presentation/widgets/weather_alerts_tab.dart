import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../domain/entities/weather_snapshot.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/weather_alert_card.dart';
import '../widgets/weather_snapshot_card.dart';

/// Weather tab of the alerts screen.
class WeatherAlertsTab extends ConsumerWidget {
  const WeatherAlertsTab({super.key});

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
          WeatherAlertCard(alert: alerts[index]),
        ],
    ];
  }
}

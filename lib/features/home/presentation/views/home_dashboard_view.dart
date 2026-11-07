import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/molecules/section_header.dart';
import '../../../alerts/presentation/viewmodels/alerts_viewmodel.dart';
import '../../../alerts/presentation/viewmodels/weather_viewmodel.dart';
import '../../../community_reports/presentation/viewmodels/community_reports_viewmodel.dart';
import '../widgets/home_emergency_shortcut.dart';
import '../widgets/home_greeting.dart';
import '../widgets/home_profile_sheet.dart';
import '../widgets/home_reports_section.dart';
import '../widgets/home_seismic_section.dart';
import '../widgets/home_status_summary.dart';
import '../widgets/home_weather_section.dart';

class HomeDashboardView extends ConsumerWidget {
  const HomeDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsViewModelProvider);
    final weather = ref.watch(weatherViewModelProvider);
    final reports = ref.watch(communityReportsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: const AppLogo(size: 32, showWordmark: true),
        actions: [
          IconButton(
            onPressed: () => context.go('/alertas'),
            tooltip: 'Ver alertas',
            icon: const Icon(LucideIcons.bell, size: 21),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () => showHomeProfileSheet(context, ref),
              tooltip: 'Perfil',
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primarySoft,
                foregroundColor: AppColors.primary,
              ),
              icon: const Icon(LucideIcons.userRound, size: 20),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshAll(ref),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          children: [
            Text(
              greetingForHour(DateTime.now().hour),
              style: AppTypography.headlineMedium,
            ),
            const SizedBox(height: 3),
            Text(
              DateFormatter.day(DateTime.now()),
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 18),
            HomeStatusSummary(
              alerts: alerts.value,
              weather: weather.value,
              reportCount: reports.value?.length,
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Clima actual',
              subtitle: 'Datos de WeatherAPI para Managua',
            ),
            const SizedBox(height: 10),
            HomeWeatherSection(weather: weather),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Últimos sismos',
              subtitle: 'Eventos de USGS en los últimos 30 días',
              actionLabel: 'Ver todos',
              onAction: () => context.go('/alertas'),
            ),
            const SizedBox(height: 10),
            HomeSeismicSection(alerts: alerts),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Reportes comunitarios',
              subtitle: 'Información enviada por la comunidad',
              actionLabel: 'Ver todos',
              onAction: () => context.go('/reportes'),
            ),
            const SizedBox(height: 10),
            HomeReportsSection(reports: reports),
            const SizedBox(height: 24),
            HomeEmergencyShortcut(onTap: () => context.go('/emergencia')),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshAll(WidgetRef ref) async {
    await Future.wait<void>([
      ref.read(alertsViewModelProvider.notifier).refresh(),
      ref.read(weatherViewModelProvider.notifier).refresh(),
      if (AppConfig.hasBackend)
        ref.read(communityReportsViewModelProvider.notifier).refresh(),
    ]);
  }
}

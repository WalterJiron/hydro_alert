import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/atoms/status_indicator.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/molecules/section_header.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../alerts/domain/entities/weather_snapshot.dart';
import '../../../alerts/presentation/viewmodels/alerts_viewmodel.dart';
import '../../../alerts/presentation/viewmodels/weather_viewmodel.dart';
import '../../../alerts/presentation/widgets/seismic_event_card.dart';
import '../../../alerts/presentation/widgets/weather_snapshot_card.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../../../community_reports/presentation/viewmodels/community_reports_viewmodel.dart';
import '../../../community_reports/presentation/widgets/community_report_card.dart';

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
              onPressed: () => _showProfileSheet(context, ref),
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
            Text(_greeting(), style: AppTypography.headlineMedium),
            const SizedBox(height: 3),
            Text(
              DateFormatter.day(DateTime.now()),
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 18),
            _StatusSummary(
              alerts: alerts.value,
              weather: weather.value,
              reportCount: reports.value?.length,
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Clima actual',
              subtitle: 'Datos de OpenWeatherMap para Managua',
            ),
            const SizedBox(height: 10),
            _WeatherSection(weather: weather),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Últimos sismos',
              subtitle: 'Eventos de USGS en los últimos 30 días',
              actionLabel: 'Ver todos',
              onAction: () => context.go('/alertas'),
            ),
            const SizedBox(height: 10),
            _SeismicSection(alerts: alerts),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Reportes comunitarios',
              subtitle: 'Información enviada por la comunidad',
              actionLabel: 'Ver todos',
              onAction: () => context.go('/reportes'),
            ),
            const SizedBox(height: 10),
            _ReportsSection(reports: reports),
            const SizedBox(height: 24),
            _EmergencyShortcut(onTap: () => context.go('/emergencia')),
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

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    }
    if (hour < 18) {
      return 'Buenas tardes';
    }
    return 'Buenas noches';
  }

  void _showProfileSheet(BuildContext context, WidgetRef ref) {
    final user = ref.read(authViewModelProvider).value;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLogo(size: 44, showWordmark: true, showTagline: true),
                const SizedBox(height: 18),
                Text(
                  user?.displayName ?? 'Invitado',
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  'Acceso como invitado. No se requiere cuenta.',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: 18),
                const InfoBanner(
                  icon: LucideIcons.info,
                  title: 'Sobre los datos',
                  message:
                      'Sismos: USGS. Clima: OpenWeatherMap. '
                      'Los reportes comunitarios no están verificados. '
                      'HydroAlert no sustituye a las autoridades.',
                ),
                const SizedBox(height: 14),
                CustomButton(
                  label: 'Cerrar sesión',
                  icon: LucideIcons.logOut,
                  variant: AppButtonVariant.ghost,
                  expand: true,
                  onPressed: () async {
                    Navigator.of(sheetContext).pop();
                    await ref.read(authViewModelProvider.notifier).signOut();
                    if (context.mounted) {
                      context.go('/bienvenida');
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
}

class _StatusSummary extends StatelessWidget {
  const _StatusSummary({
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

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.activity,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text('Resumen de hoy', style: AppTypography.titleSmall),
              const Spacer(),
              StatusIndicator(
                label: alerts == null ? 'Actualizando' : 'USGS',
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
              Container(width: 1, height: 46, color: AppColors.border),
              Expanded(
                child: _Stat(
                  value: reportCount == null ? '—' : '$reportCount',
                  label: 'Reportes',
                  hint: 'activos',
                  color: AppColors.warning,
                ),
              ),
              Container(width: 1, height: 46, color: AppColors.border),
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
        Text(
          value,
          style: AppTypography.headlineMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(hint, style: AppTypography.labelSmall),
      ],
    );
  }
}

class _WeatherSection extends ConsumerWidget {
  const _WeatherSection({required this.weather});

  final AsyncValue<WeatherSnapshot> weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!AppConfig.hasWeather) {
      return const _UnavailableCard(
        icon: LucideIcons.cloudSun,
        title: 'Clima no disponible',
        message:
            'La información meteorológica se activará cuando se configure '
            'la clave de OpenWeatherMap en esta compilación.',
      );
    }

    return weather.when(
      loading: () => const AppCard(
        child: LoadingState(message: 'Consultando el clima…', compact: true),
      ),
      error: (error, stackTrace) {
        return _UnavailableCard(
          icon: LucideIcons.cloudSun,
          title: 'Clima no disponible',
          message: error is ConfigurationFailure
              ? 'La información meteorológica se activará cuando se configure '
                    'la clave de OpenWeatherMap en esta compilación.'
              : errorMessageOf(error),
          onRetry: error is ConfigurationFailure
              ? null
              : () => ref.read(weatherViewModelProvider.notifier).refresh(),
        );
      },
      data: (snapshot) => WeatherSnapshotCard(snapshot: snapshot),
    );
  }
}

class _SeismicSection extends ConsumerWidget {
  const _SeismicSection({required this.alerts});

  final AsyncValue<List<SeismicEvent>> alerts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return alerts.when(
      loading: () => const AppCard(
        child: LoadingState(message: 'Consultando sismos…', compact: true),
      ),
      error: (error, stackTrace) => _UnavailableCard(
        icon: LucideIcons.activity,
        title: 'No pudimos cargar los sismos',
        message: errorMessageOf(error),
        onRetry: () => ref.read(alertsViewModelProvider.notifier).refresh(),
      ),
      data: (events) {
        if (events.isEmpty) {
          return const AppCard(
            child: EmptyState(
              icon: LucideIcons.activity,
              title: 'Sin sismos recientes',
              message:
                  'USGS no reporta eventos de magnitud 2.5 o superior en el área de Nicaragua durante los últimos 30 días.',
            ),
          );
        }

        final preview = events.take(3).toList();
        return Column(
          children: [
            for (var index = 0; index < preview.length; index++) ...[
              if (index > 0) const SizedBox(height: 10),
              SeismicEventCard(event: preview[index]),
            ],
          ],
        );
      },
    );
  }
}

class _ReportsSection extends ConsumerWidget {
  const _ReportsSection({required this.reports});

  final AsyncValue<List<CommunityReport>> reports;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!AppConfig.hasBackend) {
      return _UnavailableCard(
        icon: LucideIcons.clipboardList,
        title: 'Reportes aún no configurados',
        message:
            'El servicio de reportes comunitarios no está configurado en esta compilación. '
            'Los sismos y el mapa siguen disponibles.',
        onRetry: null,
      );
    }

    return reports.when(
      loading: () => const AppCard(
        child: LoadingState(message: 'Cargando reportes…', compact: true),
      ),
      error: (error, stackTrace) => _UnavailableCard(
        icon: LucideIcons.clipboardList,
        title: 'No pudimos cargar los reportes',
        message: errorMessageOf(error),
        onRetry: () =>
            ref.read(communityReportsViewModelProvider.notifier).refresh(),
      ),
      data: (items) {
        if (items.isEmpty) {
          return AppCard(
            child: Column(
              children: [
                const EmptyState(
                  icon: LucideIcons.clipboardList,
                  title: 'Aún no hay reportes activos',
                  message:
                      'Cuando la comunidad comparta una situación, aparecerá aquí.',
                ),
                const SizedBox(height: 4),
                CustomButton(
                  label: 'Crear reporte',
                  icon: LucideIcons.plus,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => context.push('/reportes/nuevo'),
                ),
              ],
            ),
          );
        }

        final preview = items.take(2).toList();
        return Column(
          children: [
            for (var index = 0; index < preview.length; index++) ...[
              if (index > 0) const SizedBox(height: 10),
              CommunityReportCard(report: preview[index]),
            ],
          ],
        );
      },
    );
  }
}

class _UnavailableCard extends StatelessWidget {
  const _UnavailableCard({
    required this.icon,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: AppColors.textMuted),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: AppTypography.titleSmall)),
            ],
          ),
          const SizedBox(height: 8),
          Text(message, style: AppTypography.bodySmall.copyWith(height: 1.45)),
          if (onRetry != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                label: 'Reintentar',
                icon: LucideIcons.refreshCw,
                variant: AppButtonVariant.ghost,
                onPressed: onRetry,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmergencyShortcut extends StatelessWidget {
  const _EmergencyShortcut({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryDark,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  LucideIcons.siren,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿Estás en una emergencia?',
                      style: AppTypography.titleSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Abre la guía visual de actuación. No envía alertas ni ubicación.',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                LucideIcons.chevronRight,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

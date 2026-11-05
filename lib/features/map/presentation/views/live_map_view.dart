import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/atoms/status_indicator.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../alerts/presentation/viewmodels/alerts_viewmodel.dart';
import '../../../alerts/presentation/widgets/seismic_event_sheet.dart';
import '../../../alerts/presentation/widgets/seismic_visuals.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../../../community_reports/presentation/viewmodels/community_reports_viewmodel.dart';
import '../../../community_reports/presentation/widgets/community_report_card.dart';
import '../../../community_reports/presentation/widgets/report_category_visuals.dart';
import '../viewmodels/map_viewmodel.dart';

class LiveMapView extends ConsumerStatefulWidget {
  const LiveMapView({super.key});

  @override
  ConsumerState<LiveMapView> createState() => _LiveMapViewState();
}

class _LiveMapViewState extends ConsumerState<LiveMapView> {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapViewModelProvider);
    final alerts = ref.watch(alertsViewModelProvider);
    final reports = ref.watch(communityReportsViewModelProvider);

    ref.listen<String?>(
      mapViewModelProvider.select((state) => state.locationError),
      (previous, next) {
        if (next != null && mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next)));
          ref.read(mapViewModelProvider.notifier).clearLocationError();
        }
      },
    );

    final events = mapState.showEarthquakes
        ? (alerts.value ?? const <SeismicEvent>[])
        : const <SeismicEvent>[];
    final visibleReports = mapState.showReports && AppConfig.hasBackend
        ? (reports.value ?? const <CommunityReport>[])
        : const <CommunityReport>[];

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(
                ApiEndpoints.nicaraguaCenterLatitude,
                ApiEndpoints.nicaraguaCenterLongitude,
              ),
              initialZoom: 7.1,
              minZoom: 5.5,
              maxZoom: 16,
              keepAlive: true,
              backgroundColor: AppColors.surfaceMuted,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: AppConfig.mapTileUrl,
                userAgentPackageName: AppConfig.mapUserAgent,
                maxZoom: 19,
              ),
              if (mapState.hasRadar)
                TileLayer(
                  urlTemplate: mapState.radarFrame!.tileUrlTemplate,
                  tileBuilder: (context, tileWidget, tile) {
                    return Opacity(opacity: 0.62, child: tileWidget);
                  },
                ),
              MarkerLayer(
                markers: [
                  for (final report in visibleReports) _reportMarker(report),
                  for (final event in events) _seismicMarker(event),
                  if (mapState.userLocation != null)
                    _userLocationMarker(mapState.userLocation!),
                ],
              ),
            ],
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            bottom: false,
            child: Column(
              children: [
                _MapHeader(
                  alertsLoading: alerts.isLoading,
                  alertsAvailable: alerts.hasValue,
                  reportsAvailable: AppConfig.hasBackend,
                ),
                const Spacer(),
                if (mapState.radarError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InfoBanner(
                      icon: LucideIcons.cloudOff,
                      tone: InfoBannerTone.warning,
                      message: mapState.radarError!,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppIconButton(
                      icon: LucideIcons.locateFixed,
                      tooltip: 'Centrar en mi ubicación',
                      isLoading: mapState.isLocating,
                      onPressed: _locateUser,
                    ),
                    const SizedBox(width: 8),
                    AppIconButton(
                      icon: LucideIcons.refreshCw,
                      tooltip: 'Actualizar datos',
                      onPressed: _refreshData,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _MapAttribution(
                    radarEnabled: mapState.hasRadar,
                    onOpenStreetMap: () =>
                        _openUrl(ApiEndpoints.openStreetMapCopyright),
                    onRainViewer: () => _openUrl(ApiEndpoints.rainViewerSite),
                  ),
                ),
                const SizedBox(height: 5),
                _LayerPanel(
                  earthquakesSelected: mapState.showEarthquakes,
                  reportsSelected: mapState.showReports,
                  radarSelected: mapState.radarEnabled,
                  radarLoading: mapState.isLoadingRadar,
                  earthquakeCount: alerts.value?.length,
                  reportCount: reports.value?.length,
                  onToggleEarthquakes: () => ref
                      .read(mapViewModelProvider.notifier)
                      .toggleEarthquakes(),
                  onToggleReports: AppConfig.hasBackend
                      ? () => ref
                            .read(mapViewModelProvider.notifier)
                            .toggleReports()
                      : null,
                  onToggleRadar: _toggleRadar,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Marker _seismicMarker(SeismicEvent event) {
    final color = seismicColorFor(event.magnitude);
    final size = event.magnitude >= 5.0 ? 42.0 : 36.0;

    return Marker(
      point: LatLng(event.latitude, event.longitude),
      width: 48,
      height: 48,
      child: GestureDetector(
        onTap: () => showSeismicEventSheet(context, event),
        child: Center(
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.mapMarkerBorder, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              event.magnitudeLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Marker _reportMarker(CommunityReport report) {
    final color = reportCategoryColor(report.category);

    return Marker(
      point: LatLng(report.latitude, report.longitude),
      width: 42,
      height: 42,
      child: GestureDetector(
        onTap: () => _showReportSheet(report),
        child: Center(
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.mapMarkerBorder, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              reportCategoryIcon(report.category),
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Marker _userLocationMarker(LatLng location) {
    return Marker(
      point: location,
      width: 32,
      height: 32,
      child: Center(
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.mapUserLocation,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.mapUserLocation.withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _locateUser() async {
    final location = await ref.read(mapViewModelProvider.notifier).locateUser();
    if (location != null && mounted) {
      _mapController.move(location, 12.5);
    }
  }

  Future<void> _toggleRadar() async {
    await ref.read(mapViewModelProvider.notifier).toggleRadar();
    if (!mounted) {
      return;
    }
    final error = ref.read(mapViewModelProvider).radarError;
    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  Future<void> _refreshData() async {
    await Future.wait<void>([
      ref.read(alertsViewModelProvider.notifier).refresh(),
      if (AppConfig.hasBackend)
        ref.read(communityReportsViewModelProvider.notifier).refresh(),
      if (ref.read(mapViewModelProvider).radarEnabled)
        ref.read(mapViewModelProvider.notifier).loadRadar(),
    ]);
  }

  void _showReportSheet(CommunityReport report) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommunityReportCard(report: report, compact: true),
                const SizedBox(height: 12),
                const InfoBanner(
                  icon: LucideIcons.shieldAlert,
                  tone: InfoBannerTone.warning,
                  message:
                      'Reporte comunitario sin verificar. No es una alerta oficial.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader({
    required this.alertsLoading,
    required this.alertsAvailable,
    required this.reportsAvailable,
  });

  final bool alertsLoading;
  final bool alertsAvailable;
  final bool reportsAvailable;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppLogo(size: 30, showWordmark: true),
              const Spacer(),
              const AlertBadge(
                label: 'Nicaragua',
                tone: AppBadgeTone.info,
                icon: LucideIcons.mapPin,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              StatusIndicator(
                label: alertsLoading ? 'USGS actualizando' : 'USGS',
                color: AppColors.info,
                isActive: alertsAvailable,
              ),
              StatusIndicator(
                label: reportsAvailable
                    ? 'Reportes activos'
                    : 'Reportes sin configurar',
                color: AppColors.warning,
                isActive: reportsAvailable,
              ),
              const StatusIndicator(
                label: 'Toca un marcador',
                color: AppColors.success,
                isActive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LayerPanel extends StatelessWidget {
  const _LayerPanel({
    required this.earthquakesSelected,
    required this.reportsSelected,
    required this.radarSelected,
    required this.radarLoading,
    required this.earthquakeCount,
    required this.reportCount,
    required this.onToggleEarthquakes,
    required this.onToggleReports,
    required this.onToggleRadar,
  });

  final bool earthquakesSelected;
  final bool reportsSelected;
  final bool radarSelected;
  final bool radarLoading;
  final int? earthquakeCount;
  final int? reportCount;
  final VoidCallback onToggleEarthquakes;
  final VoidCallback? onToggleReports;
  final VoidCallback onToggleRadar;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _LayerChip(
            icon: LucideIcons.activity,
            label: 'Sismos',
            count: earthquakeCount,
            selected: earthquakesSelected,
            color: AppColors.info,
            onTap: onToggleEarthquakes,
          ),
          _LayerChip(
            icon: LucideIcons.clipboardList,
            label: 'Reportes',
            count: reportCount,
            selected: reportsSelected,
            color: AppColors.warning,
            onTap: onToggleReports,
          ),
          _LayerChip(
            icon: LucideIcons.radar,
            label: 'Radar',
            selected: radarSelected,
            color: AppColors.primary,
            isLoading: radarLoading,
            onTap: onToggleRadar,
          ),
        ],
      ),
    );
  }
}

class _LayerChip extends StatelessWidget {
  const _LayerChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
    this.count,
    this.isLoading = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback? onTap;
  final int? count;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    final isSelected = selected && isEnabled;

    return Material(
      color: isSelected ? color.withValues(alpha: 0.1) : AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? color.withValues(alpha: 0.5)
                  : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  icon,
                  size: 16,
                  color: isEnabled
                      ? (isSelected ? color : AppColors.textSecondary)
                      : AppColors.textMuted,
                ),
              const SizedBox(width: 6),
              Text(
                count == null ? label : '$label · $count',
                style: AppTypography.labelSmall.copyWith(
                  color: isEnabled
                      ? (isSelected ? color : AppColors.textSecondary)
                      : AppColors.textMuted,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 4),
                Icon(LucideIcons.check, size: 13, color: color),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Always-visible map attribution. The standard attribution widget sits behind
/// the controls in this layout, so a compact clickable credit is shown above
/// the layer panel instead.
class _MapAttribution extends StatelessWidget {
  const _MapAttribution({
    required this.radarEnabled,
    required this.onOpenStreetMap,
    required this.onRainViewer,
  });

  final bool radarEnabled;
  final VoidCallback onOpenStreetMap;
  final VoidCallback onRainViewer;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AttributionLink(label: '© OpenStreetMap', onTap: onOpenStreetMap),
            if (radarEnabled) ...[
              Text(
                ' · ',
                style: AppTypography.labelSmall.copyWith(fontSize: 10),
              ),
              _AttributionLink(label: 'RainViewer', onTap: onRainViewer),
            ],
          ],
        ),
      ),
    );
  }
}

class _AttributionLink extends StatelessWidget {
  const _AttributionLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            fontSize: 10,
            color: AppColors.textSecondary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

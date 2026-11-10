import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/services/location_service.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/motion/app_animated_entrance.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../alerts/presentation/viewmodels/alerts_viewmodel.dart';
import '../../../alerts/presentation/widgets/seismic_event_sheet.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../../../community_reports/presentation/viewmodels/community_reports_viewmodel.dart';
import '../../../community_reports/presentation/widgets/community_report_sheet.dart';
import '../controllers/map_marker_controller.dart';
import '../controllers/radar_overlay_controller.dart';
import '../viewmodels/map_viewmodel.dart';
import '../viewmodels/map_view_state.dart';
import '../widgets/map_controls.dart';
import '../widgets/map_layer_bar.dart';
import '../widgets/map_legend_sheet.dart';
import '../widgets/map_location_banner.dart';
import '../widgets/map_top_bar.dart';

class LiveMapView extends ConsumerStatefulWidget {
  const LiveMapView({super.key});

  @override
  ConsumerState<LiveMapView> createState() => _LiveMapViewState();
}

class _LiveMapViewState extends ConsumerState<LiveMapView> {
  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(
      ApiEndpoints.nicaraguaCenterLatitude,
      ApiEndpoints.nicaraguaCenterLongitude,
    ),
    zoom: 7.1,
  );

  final MapMarkerController _markerController = MapMarkerController();
  final RadarOverlayController _radarController = RadarOverlayController();

  GoogleMapController? _mapController;
  CameraPosition _cameraPosition = _initialCamera;

  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        ref.read(mapViewModelProvider.notifier).checkLocationAvailability();
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref.read(mapViewModelProvider.notifier).checkLocationAvailability();
    });
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    _mapController?.dispose();
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
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    // The wave navbar height is (barHeight: 54 + protrusion: 7) + bottomInset = 61 + bottomInset.
    // We add 16px of floating margin so MapLayerBar floats cleanly above the wave:
    final layerBarBottomPadding = bottomInset + 77.0;

    _requestMarkerIcons(
      events: events,
      reports: visibleReports,
      hasUserLocation: mapState.userLocation != null,
      pixelRatio: pixelRatio,
    );

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCamera,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onCameraMove: (position) => _cameraPosition = position,
            markers: _markerController.buildMarkers(
              events: events,
              reports: visibleReports,
              userLocation: mapState.userLocation,
              pixelRatio: pixelRatio,
              onReportTap: _showReportSheet,
              onSeismicTap: (event) => showSeismicEventSheet(context, event),
            ),
            tileOverlays: mapState.hasRadar
                ? {
                    _radarController.overlayFor(
                      mapState.radarFrame!.tileUrlTemplate,
                    ),
                  }
                : const <TileOverlay>{},
            minMaxZoomPreference: const MinMaxZoomPreference(5.5, 16),
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            compassEnabled: false,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            // The map is shifted with padding so the Google logo and the
            // camera centre stay clear of the floating controls.
            padding: EdgeInsets.only(
              top: 60,
              bottom: layerBarBottomPadding + 8,
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.fromLTRB(14, 8, 14, layerBarBottomPadding),
            bottom: false,
            child: Column(
              children: [
                AppAnimatedEntrance(
                  order: 0,
                  offset: const Offset(0, -0.12),
                  child: MapTopBar(
                    alertsLoading: alerts.isLoading,
                    alertsAvailable: alerts.hasValue,
                    alertsCount: alerts.value?.length,
                    sourceLabel: alerts.value?.isNotEmpty == true
                        ? alerts.value!.first.source
                        : null,
                    onOpenLegend: _openLegend,
                  ),
                ),
                if (mapState.hasRadar) ...[
                  const SizedBox(height: 6),
                  AppAnimatedEntrance(
                    order: 1,
                    offset: const Offset(0, -0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withValues(alpha: 0.90),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.radar,
                            size: 13,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Radar de lluvia activo',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                AppAnimatedEntrance(
                  order: 1,
                  offset: const Offset(0.12, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: MapControls(
                      isLocating: mapState.isLocating,
                      onZoomIn: () => _zoomBy(1),
                      onZoomOut: () => _zoomBy(-1),
                      onLocate: _locateUser,
                      onRefresh: _refreshData,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (mapState.radarError != null)
                  AppAnimatedEntrance(
                    order: 2,
                    offset: const Offset(0, 0.06),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: InfoBanner(
                        icon: LucideIcons.cloudOff,
                        tone: InfoBannerTone.warning,
                        message: mapState.radarError!,
                      ),
                    ),
                  ),
                if (_showLocationBanner(mapState))
                  AppAnimatedEntrance(
                    order: 2,
                    offset: const Offset(0, 0.06),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: MapLocationBanner(
                        availability: mapState.locationAvailability!,
                        onResolve: () => ref
                            .read(mapViewModelProvider.notifier)
                            .resolveLocationIssue(),
                        onDismiss: () => ref
                            .read(mapViewModelProvider.notifier)
                            .dismissLocationBanner(),
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                AppAnimatedEntrance(
                  order: 3,
                  offset: const Offset(0, 0.1),
                  child: MapLayerBar(
                    earthquakesSelected: mapState.showEarthquakes,
                    reportsSelected: mapState.showReports,
                    radarSelected: mapState.radarEnabled,
                    radarLoading: mapState.isLoadingRadar,
                    reportsEnabled: AppConfig.hasBackend,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _showLocationBanner(MapViewState state) {
    final availability = state.locationAvailability;
    return availability != null &&
        availability != LocationAvailability.ready &&
        !state.locationBannerDismissed;
  }

  void _requestMarkerIcons({
    required List<SeismicEvent> events,
    required List<CommunityReport> reports,
    required bool hasUserLocation,
    required double pixelRatio,
  }) {
    _markerController.requestMissing(
      events: events,
      reports: reports,
      hasUserLocation: hasUserLocation,
      pixelRatio: pixelRatio,
      onReady: () {
        if (!mounted) {
          return;
        }
        setState(() {});
      },
    );
  }

  void _zoomBy(double delta) {
    final controller = _mapController;
    if (controller == null) {
      return;
    }
    final zoom = (_cameraPosition.zoom + delta).clamp(5.5, 16.0).toDouble();
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _cameraPosition.target, zoom: zoom),
      ),
    );
  }

  Future<void> _locateUser() async {
    final notifier = ref.read(mapViewModelProvider.notifier);
    final state = ref.read(mapViewModelProvider);
    final availability = state.locationAvailability;

    if (availability != null && availability != LocationAvailability.ready) {
      notifier.revealLocationBanner();
      return;
    }

    final location = await notifier.locateUser();
    final controller = _mapController;
    if (location != null && mounted && controller != null) {
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(location.latitude, location.longitude),
          12.5,
        ),
      );
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

  void _openLegend() {
    showMapLegendSheet(context, reportsAvailable: AppConfig.hasBackend);
  }

  void _showReportSheet(CommunityReport report) {
    showCommunityReportSheet(context, report, compact: true);
  }
}

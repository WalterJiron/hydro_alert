import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/utils/external_link.dart';
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
import '../widgets/map_radar_attribution.dart';
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
            padding: const EdgeInsets.only(top: 60, bottom: 92),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            bottom: false,
            child: Column(
              children: [
                AppAnimatedEntrance(
                  order: 0,
                  offset: const Offset(0, -0.12),
                  child: MapTopBar(
                    alertsLoading: alerts.isLoading,
                    alertsAvailable: alerts.hasValue,
                    onOpenLegend: _openLegend,
                  ),
                ),
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
                if (mapState.hasRadar)
                  AppAnimatedEntrance(
                    order: 2,
                    offset: const Offset(0.08, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MapRadarAttribution(
                        onRainViewer: () async {
                          await openExternalUrl(ApiEndpoints.rainViewerSite);
                        },
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/utils/external_link.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/motion/app_animated_entrance.dart';
import '../../../../shared/motion/app_motion.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../alerts/presentation/viewmodels/alerts_viewmodel.dart';
import '../../../alerts/presentation/widgets/seismic_event_sheet.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../../../community_reports/presentation/viewmodels/community_reports_viewmodel.dart';
import '../../../community_reports/presentation/widgets/community_report_sheet.dart';
import '../../domain/entities/radar_frame.dart';
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

class _LiveMapViewState extends ConsumerState<LiveMapView>
    with SingleTickerProviderStateMixin {
  static const double _initialZoom = 7.1;
  static const Duration _radarFrameDuration = Duration(milliseconds: 620);

  static final CameraViewportState _initialViewport = CameraViewportState(
    center: Point(
      coordinates: Position(
        ApiEndpoints.nicaraguaCenterLongitude,
        ApiEndpoints.nicaraguaCenterLatitude,
      ),
    ),
    zoom: _initialZoom,
  );

  static final MbxEdgeInsets _mapPadding = MbxEdgeInsets(
    top: 60,
    bottom: 92,
    left: 0,
    right: 0,
  );

  MapMarkerController _markerController = MapMarkerController();
  RadarOverlayController _radarController = RadarOverlayController();
  final ValueNotifier<RadarFrame?> _activeRadarFrame =
      ValueNotifier<RadarFrame?>(null);

  MapboxMap? _mapController;
  CameraState? _cameraState;

  late final Ticker _radarTicker;
  late final AppLifecycleListener _lifecycleListener;

  List<RadarFrame> _radarFrames = const <RadarFrame>[];
  int _radarIndex = 0;
  Duration _lastRadarTick = Duration.zero;
  int _mapAttempt = 0;
  bool _mapFailed = false;

  @override
  void initState() {
    super.initState();
    _radarTicker = createTicker(_onRadarTick);
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
    _radarTicker.dispose();
    _lifecycleListener.dispose();
    _markerController.dispose();
    _radarController.dispose();
    _activeRadarFrame.dispose();
    _mapController = null;
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

    _markerController.sync(
      events: events,
      reports: visibleReports,
      userLocation: mapState.userLocation,
      pixelRatio: pixelRatio,
    );
    _syncRadar(mapState, reducedMotion: AppMotion.isReduced(context));

    final mapUsable = AppConfig.hasMapbox && !_mapFailed;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _buildMapSurface(context)),
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
                    child: IgnorePointer(
                      ignoring: !mapUsable,
                      child: AnimatedOpacity(
                        opacity: mapUsable ? 1 : 0.45,
                        duration: AppMotion.resolve(context, AppMotion.quick),
                        child: MapControls(
                          isLocating: mapState.isLocating,
                          onZoomIn: () => _zoomBy(1),
                          onZoomOut: () => _zoomBy(-1),
                          onLocate: _locateUser,
                          onRefresh: _refreshData,
                        ),
                      ),
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
                      child: ValueListenableBuilder<RadarFrame?>(
                        valueListenable: _activeRadarFrame,
                        builder: (context, frame, _) {
                          return MapRadarAttribution(
                            frame: frame,
                            onRainViewer: () async {
                              await openExternalUrl(
                                ApiEndpoints.rainViewerSite,
                              );
                            },
                          );
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
                    radarEnabled: mapUsable,
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
                    onToggleRadar: mapUsable ? _toggleRadar : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSurface(BuildContext context) {
    if (!AppConfig.hasMapbox || _mapFailed) {
      return _MapUnavailable(
        configured: AppConfig.hasMapbox,
        onRetry: AppConfig.hasMapbox ? _retryMap : null,
      );
    }

    return MapWidget(
      key: ValueKey<int>(_mapAttempt),
      styleUri: MapboxStyles.OUTDOORS,
      viewport: _initialViewport,
      onMapCreated: _onMapCreated,
      onStyleLoadedListener: (_) {
        _radarController.setStyleReady(true);
      },
      onCameraChangeListener: (event) {
        _cameraState = event.cameraState;
      },
      onMapLoadErrorListener: (event) {
        if (!mounted) {
          return;
        }
        setState(() => _mapFailed = true);
      },
    );
  }

  void _onMapCreated(MapboxMap map) {
    _mapController = map;
    _cameraState = null;
    _markerController.attach(
      map,
      onReportTap: _showReportSheet,
      onSeismicTap: (event) => showSeismicEventSheet(context, event),
    );
    _radarController.attach(map);
    _radarController.setBelowLayerId(_markerController.annotationBaseLayerId);
    unawaited(_configureMap(map));
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _configureMap(MapboxMap map) async {
    try {
      await map.gestures.updateSettings(
        GesturesSettings(
          rotateEnabled: false,
          pitchEnabled: false,
          scrollEnabled: true,
          pinchToZoomEnabled: true,
          doubleTapToZoomInEnabled: true,
          doubleTouchToZoomOutEnabled: true,
          quickZoomEnabled: false,
        ),
      );
      await map.logo.updateSettings(
        LogoSettings(
          enabled: true,
          position: OrnamentPosition.BOTTOM_LEFT,
          marginLeft: 12,
          marginBottom: 96,
        ),
      );
      await map.attribution.updateSettings(
        AttributionSettings(
          enabled: true,
          position: OrnamentPosition.BOTTOM_RIGHT,
          marginRight: 12,
          marginBottom: 142,
          clickable: true,
        ),
      );
      await map.compass.updateSettings(CompassSettings(enabled: false));
      await map.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
      await map.setBounds(
        CameraBoundsOptions(
          minZoom: 5.5,
          maxZoom: 16,
          minPitch: 0,
          maxPitch: 0,
        ),
      );
      await map.setCamera(
        CameraOptions(
          center: Point(
            coordinates: Position(
              ApiEndpoints.nicaraguaCenterLongitude,
              ApiEndpoints.nicaraguaCenterLatitude,
            ),
          ),
          zoom: _initialZoom,
          padding: _mapPadding,
          bearing: 0,
          pitch: 0,
        ),
      );
    } catch (_) {
      // The map keeps the SDK defaults when a setting is not supported.
    }
  }

  void _syncRadar(MapViewState state, {required bool reducedMotion}) {
    final frames = state.radarFrames;
    if (!identical(frames, _radarFrames)) {
      _radarFrames = frames;
      _radarIndex = 0;
      _lastRadarTick = Duration.zero;
    }

    if (!state.hasRadar || frames.isEmpty) {
      _radarController.sync(enabled: false, frames: frames, activeIndex: 0);
      _stopRadarLoop();
      _publishRadarFrame(null);
      return;
    }

    if (reducedMotion) {
      _radarIndex = frames.length - 1;
      _lastRadarTick = Duration.zero;
      _stopRadarLoop();
    } else if (_radarIndex >= frames.length) {
      _radarIndex = frames.length - 1;
    }

    _radarController.sync(
      enabled: true,
      frames: frames,
      activeIndex: _radarIndex,
    );
    _publishRadarFrame(frames[_radarIndex]);
    if (!reducedMotion) {
      _startRadarLoop();
    }
  }

  void _startRadarLoop() {
    if (_radarTicker.isTicking) {
      return;
    }
    _lastRadarTick = Duration.zero;
    _radarTicker.start();
  }

  void _stopRadarLoop() {
    if (_radarTicker.isTicking) {
      _radarTicker.stop();
    }
    _lastRadarTick = Duration.zero;
  }

  void _onRadarTick(Duration elapsed) {
    if (_radarFrames.isEmpty) {
      _stopRadarLoop();
      return;
    }

    final elapsedMs = (elapsed - _lastRadarTick).inMilliseconds;
    final steps = elapsedMs ~/ _radarFrameDuration.inMilliseconds;
    if (steps <= 0) {
      return;
    }

    _lastRadarTick = elapsed;
    final next = (_radarIndex + steps) % _radarFrames.length;
    _radarIndex = next;
    _radarController.sync(
      enabled: true,
      frames: _radarFrames,
      activeIndex: next,
    );
    _activeRadarFrame.value = _radarFrames[next];
  }

  void _publishRadarFrame(RadarFrame? frame) {
    if (identical(_activeRadarFrame.value, frame)) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _activeRadarFrame.value = frame;
      }
    });
  }

  void _retryMap() {
    _markerController.dispose();
    _radarController.dispose();
    _markerController = MapMarkerController();
    _radarController = RadarOverlayController();
    _mapController = null;
    _cameraState = null;
    _activeRadarFrame.value = null;
    _radarIndex = 0;
    _lastRadarTick = Duration.zero;
    setState(() {
      _mapFailed = false;
      _mapAttempt++;
    });
  }

  bool _showLocationBanner(MapViewState state) {
    final availability = state.locationAvailability;
    return availability != null &&
        availability != LocationAvailability.ready &&
        !state.locationBannerDismissed;
  }

  void _zoomBy(double delta) {
    final controller = _mapController;
    if (controller == null) {
      return;
    }
    final current = _cameraState?.zoom ?? _initialZoom;
    final zoom = (current + delta).clamp(5.5, 16.0).toDouble();
    unawaited(
      controller.easeTo(
        CameraOptions(zoom: zoom),
        MapAnimationOptions(
          duration: AppMotion.resolve(
            context,
            AppMotion.standard,
          ).inMilliseconds,
        ),
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
      await controller.easeTo(
        CameraOptions(
          center: Point(
            coordinates: Position(location.longitude, location.latitude),
          ),
          zoom: 12.5,
          padding: _mapPadding,
        ),
        MapAnimationOptions(
          duration: AppMotion.resolve(
            context,
            AppMotion.emphasized,
          ).inMilliseconds,
        ),
      );
    }
  }

  Future<void> _toggleRadar() async {
    if (!AppConfig.hasMapbox || _mapFailed) {
      return;
    }
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

class _MapUnavailable extends StatelessWidget {
  const _MapUnavailable({required this.configured, this.onRetry});

  final bool configured;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surfaceMuted,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: AppCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    configured ? LucideIcons.cloudOff : LucideIcons.mapPinOff,
                    size: 34,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    configured
                        ? 'El mapa no pudo cargarse'
                        : 'Mapa no disponible',
                    textAlign: TextAlign.center,
                    style: AppTypography.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    configured
                        ? 'Revisa tu conexión e inténtalo de nuevo.'
                        : 'Esta compilación no incluye la configuración del '
                              'mapa. Las demás secciones siguen funcionando.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySmall,
                  ),
                  if (onRetry != null) ...[
                    const SizedBox(height: 14),
                    FilledButton.tonalIcon(
                      onPressed: onRetry,
                      icon: const Icon(LucideIcons.refreshCw, size: 16),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

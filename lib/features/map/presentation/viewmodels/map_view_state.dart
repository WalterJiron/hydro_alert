import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/radar_frame.dart';

part 'map_view_state.freezed.dart';

@freezed
abstract class MapViewState with _$MapViewState {
  const factory MapViewState({
    @Default(true) bool showEarthquakes,
    @Default(true) bool showReports,
    @Default(false) bool radarEnabled,
    @Default(false) bool isLoadingRadar,
    @Default(false) bool isLocating,
    RadarFrame? radarFrame,
    String? radarError,
    LatLng? userLocation,
    String? locationError,
  }) = _MapViewState;

  const MapViewState._();

  bool get hasRadar => radarEnabled && radarFrame != null;
}

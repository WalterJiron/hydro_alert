import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/services/location_service.dart';
import '../../data/repositories/rainviewer_repository.dart';
import 'map_view_state.dart';

part 'map_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class MapViewModel extends _$MapViewModel {
  @override
  MapViewState build() => const MapViewState();

  void toggleEarthquakes() {
    state = state.copyWith(showEarthquakes: !state.showEarthquakes);
  }

  void toggleReports() {
    state = state.copyWith(showReports: !state.showReports);
  }

  Future<void> toggleRadar() async {
    if (state.radarEnabled) {
      state = state.copyWith(radarEnabled: false, radarError: null);
      return;
    }

    await loadRadar();
  }

  Future<void> loadRadar() async {
    if (state.isLoadingRadar) {
      return;
    }

    state = state.copyWith(
      isLoadingRadar: true,
      radarError: null,
      radarEnabled: true,
    );

    try {
      final frame = await ref
          .read(rainViewerDataSourceProvider)
          .fetchLatestRadarFrame();
      if (!ref.mounted) {
        return;
      }
      if (frame == null) {
        state = state.copyWith(
          isLoadingRadar: false,
          radarEnabled: false,
          radarError: 'No hay imágenes de radar disponibles en este momento.',
        );
        return;
      }
      state = state.copyWith(
        isLoadingRadar: false,
        radarEnabled: true,
        radarFrame: frame,
      );
    } on AppFailure catch (error) {
      if (!ref.mounted) {
        return;
      }
      state = state.copyWith(
        isLoadingRadar: false,
        radarEnabled: false,
        radarError: error.message,
      );
    } catch (_) {
      if (!ref.mounted) {
        return;
      }
      state = state.copyWith(
        isLoadingRadar: false,
        radarEnabled: false,
        radarError: 'No pudimos cargar la capa de radar.',
      );
    }
  }

  Future<LatLng?> locateUser() async {
    if (state.isLocating) {
      return state.userLocation;
    }

    state = state.copyWith(isLocating: true, locationError: null);
    try {
      final position = await ref
          .read(locationServiceProvider)
          .getCurrentPosition();
      final location = LatLng(position.latitude, position.longitude);
      if (!ref.mounted) {
        return null;
      }
      state = state.copyWith(isLocating: false, userLocation: location);
      return location;
    } on AppFailure catch (error) {
      if (!ref.mounted) {
        return null;
      }
      state = state.copyWith(isLocating: false, locationError: error.message);
      return null;
    } catch (_) {
      if (!ref.mounted) {
        return null;
      }
      state = state.copyWith(
        isLocating: false,
        locationError: 'No pudimos obtener tu ubicación.',
      );
      return null;
    }
  }

  void clearLocationError() {
    if (state.locationError == null) {
      return;
    }
    state = state.copyWith(locationError: null);
  }
}

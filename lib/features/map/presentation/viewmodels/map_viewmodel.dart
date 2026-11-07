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

  Future<void> checkLocationAvailability() async {
    try {
      final availability = await ref
          .read(locationServiceProvider)
          .checkAvailability();
      if (!ref.mounted) {
        return;
      }
      state = state.copyWith(
        locationAvailability: availability,
        locationBannerDismissed: availability == LocationAvailability.ready
            ? false
            : state.locationBannerDismissed,
      );
    } catch (_) {
      // Keep the last known state when the device cannot report availability.
    }
  }

  void dismissLocationBanner() {
    if (state.locationBannerDismissed) {
      return;
    }
    state = state.copyWith(locationBannerDismissed: true);
  }

  void revealLocationBanner() {
    if (!state.locationBannerDismissed) {
      return;
    }
    state = state.copyWith(locationBannerDismissed: false);
  }

  /// Opens the right system screen (or asks for the permission again) for the
  /// current location problem.
  Future<void> resolveLocationIssue() async {
    final availability = state.locationAvailability;
    if (availability == null || availability == LocationAvailability.ready) {
      await locateUser();
      return;
    }

    if (availability == LocationAvailability.serviceDisabled) {
      await ref.read(locationServiceProvider).openLocationSettings();
      return;
    }

    if (availability == LocationAvailability.permissionDeniedForever) {
      await ref.read(locationServiceProvider).openAppSettings();
      return;
    }

    final granted = await ref.read(locationServiceProvider).ensurePermission();
    if (!ref.mounted) {
      return;
    }
    if (granted) {
      state = state.copyWith(locationAvailability: LocationAvailability.ready);
      await locateUser();
    } else {
      await checkLocationAvailability();
    }
  }

  Future<LatLng?> locateUser() async {
    if (state.isLocating) {
      return state.userLocation;
    }

    state = state.copyWith(isLocating: true, locationError: null);
    try {
      final service = ref.read(locationServiceProvider);
      final availability = await service.checkAvailability();
      if (!ref.mounted) {
        return null;
      }

      if (availability != LocationAvailability.ready) {
        state = state.copyWith(
          isLocating: false,
          locationAvailability: availability,
          locationBannerDismissed: false,
        );
        return null;
      }

      final position = await service.getCurrentPosition();
      final location = LatLng(position.latitude, position.longitude);
      if (!ref.mounted) {
        return null;
      }
      state = state.copyWith(
        isLocating: false,
        userLocation: location,
        locationAvailability: LocationAvailability.ready,
      );
      return location;
    } on AppFailure catch (error) {
      if (!ref.mounted) {
        return null;
      }
      final availability = await _readAvailability();
      if (!ref.mounted) {
        return null;
      }
      final isReady = availability == LocationAvailability.ready;
      state = state.copyWith(
        isLocating: false,
        locationAvailability: availability,
        locationBannerDismissed: isReady
            ? state.locationBannerDismissed
            : false,
        locationError: isReady ? error.message : null,
      );
      return null;
    } catch (_) {
      if (!ref.mounted) {
        return null;
      }
      final availability = await _readAvailability();
      if (!ref.mounted) {
        return null;
      }
      final isReady = availability == LocationAvailability.ready;
      state = state.copyWith(
        isLocating: false,
        locationAvailability: availability,
        locationBannerDismissed: isReady
            ? state.locationBannerDismissed
            : false,
        locationError: isReady ? 'No pudimos obtener tu ubicación.' : null,
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

  Future<LocationAvailability?> _readAvailability() async {
    try {
      return await ref.read(locationServiceProvider).checkAvailability();
    } catch (_) {
      return null;
    }
  }
}

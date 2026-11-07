import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../errors/app_failure.dart';

/// Whether location can be used right now, and why it cannot.
enum LocationAvailability {
  ready,
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
}

/// Wraps geolocator with permission handling and user-friendly failures.
class LocationService {
  const LocationService();

  Future<LocationAvailability> checkAvailability() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationAvailability.serviceDisabled;
    }

    final permission = await Geolocator.checkPermission();
    return switch (permission) {
      LocationPermission.always ||
      LocationPermission.whileInUse => LocationAvailability.ready,
      LocationPermission.deniedForever =>
        LocationAvailability.permissionDeniedForever,
      LocationPermission.denied || LocationPermission.unableToDetermine =>
        LocationAvailability.permissionDenied,
    };
  }

  Future<bool> ensurePermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> isServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  Future<Position> getCurrentPosition() async {
    try {
      final availability = await checkAvailability();
      if (availability == LocationAvailability.serviceDisabled) {
        throw const LocationFailure(
          message:
              'La ubicación del dispositivo está desactivada. Actívala para continuar.',
        );
      }

      if (availability == LocationAvailability.permissionDenied) {
        final granted = await ensurePermission();
        if (!granted) {
          throw const LocationFailure(
            message:
                'Necesitamos acceso a tu ubicación para mostrar el mapa y enviar reportes.',
          );
        }
      }

      if (availability == LocationAvailability.permissionDeniedForever) {
        throw const LocationFailure(
          message:
              'El permiso de ubicación está bloqueado. Habilítalo desde los ajustes del dispositivo.',
        );
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (error) {
      throw LocationFailure(
        message: 'No pudimos obtener tu ubicación. Inténtalo de nuevo.',
        cause: error,
      );
    }
  }
}

final locationServiceProvider = Provider<LocationService>((ref) {
  return const LocationService();
});

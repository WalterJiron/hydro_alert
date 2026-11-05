import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../errors/app_failure.dart';

/// Wraps geolocator with permission handling and user-friendly failures.
class LocationService {
  const LocationService();

  Future<bool> isServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<Position> getCurrentPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const LocationFailure(
          message:
              'La ubicación del dispositivo está desactivada. Actívala para continuar.',
        );
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw const LocationFailure(
          message:
              'Necesitamos acceso a tu ubicación para mostrar el mapa y enviar reportes.',
        );
      }

      if (permission == LocationPermission.deniedForever) {
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

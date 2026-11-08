import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydro_alert/core/errors/app_failure.dart';
import 'package:hydro_alert/core/services/location_service.dart';
import 'package:hydro_alert/features/map/presentation/viewmodels/map_viewmodel.dart';

void main() {
  group('MapViewModel location availability', () {
    late _FakeLocationService location;
    late ProviderContainer container;

    setUp(() {
      location = _FakeLocationService(LocationAvailability.serviceDisabled);
      container = ProviderContainer(
        overrides: [locationServiceProvider.overrideWithValue(location)],
      );
      addTearDown(container.dispose);
    });

    test(
      'reports a disabled location service and exposes the banner',
      () async {
        await container
            .read(mapViewModelProvider.notifier)
            .checkLocationAvailability();

        final state = container.read(mapViewModelProvider);
        expect(
          state.locationAvailability,
          LocationAvailability.serviceDisabled,
        );
        expect(state.hasLocationIssue, isTrue);
        expect(state.locationBannerDismissed, isFalse);
      },
    );

    test('dismissing hides the banner until the state changes', () async {
      final notifier = container.read(mapViewModelProvider.notifier);
      await notifier.checkLocationAvailability();

      notifier.dismissLocationBanner();
      expect(
        container.read(mapViewModelProvider).locationBannerDismissed,
        isTrue,
      );

      location.availability = LocationAvailability.ready;
      await notifier.checkLocationAvailability();

      final state = container.read(mapViewModelProvider);
      expect(state.locationAvailability, LocationAvailability.ready);
      expect(state.hasLocationIssue, isFalse);
      expect(state.locationBannerDismissed, isFalse);
    });

    test('locating is skipped when the service is disabled', () async {
      final notifier = container.read(mapViewModelProvider.notifier);
      await notifier.checkLocationAvailability();
      notifier.dismissLocationBanner();

      final result = await notifier.locateUser();

      expect(result, isNull);
      expect(location.positionCalls, 0);
      final state = container.read(mapViewModelProvider);
      expect(state.isLocating, isFalse);
      expect(state.locationBannerDismissed, isFalse);
      expect(state.locationError, isNull);
    });

    test(
      'resolving a disabled service opens system location settings',
      () async {
        final notifier = container.read(mapViewModelProvider.notifier);
        await notifier.checkLocationAvailability();

        await notifier.resolveLocationIssue();

        expect(location.openedLocationSettings, 1);
        expect(location.openedAppSettings, 0);
      },
    );
  });
}

class _FakeLocationService extends LocationService {
  _FakeLocationService(this.availability);

  LocationAvailability availability;
  int positionCalls = 0;
  int openedLocationSettings = 0;
  int openedAppSettings = 0;
  bool permissionGranted = false;

  @override
  Future<LocationAvailability> checkAvailability() async => availability;

  @override
  Future<bool> ensurePermission() async => permissionGranted;

  @override
  Future<bool> openLocationSettings() async {
    openedLocationSettings++;
    return true;
  }

  @override
  Future<bool> openAppSettings() async {
    openedAppSettings++;
    return true;
  }

  @override
  Future<Position> getCurrentPosition() async {
    positionCalls++;
    throw const LocationFailure(message: 'Ubicación no disponible.');
  }
}

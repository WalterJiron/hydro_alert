import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/services/location_service.dart';
import '../../../../shared/molecules/info_banner.dart';

/// Copy shown by the map location banner for a given availability.
class MapLocationBannerContent {
  const MapLocationBannerContent({
    required this.title,
    required this.message,
    required this.actionLabel,
  });

  final String title;
  final String message;
  final String actionLabel;

  static MapLocationBannerContent from(LocationAvailability availability) {
    return switch (availability) {
      LocationAvailability.serviceDisabled => const MapLocationBannerContent(
        title: 'Ubicación desactivada',
        message:
            'Activa la ubicación del dispositivo para centrar el mapa en tu zona.',
        actionLabel: 'Activar ubicación',
      ),
      LocationAvailability.permissionDenied => const MapLocationBannerContent(
        title: 'Permiso de ubicación',
        message:
            'HydroAlert usa tu ubicación solo cuando abres el mapa o un reporte.',
        actionLabel: 'Permitir acceso',
      ),
      LocationAvailability.permissionDeniedForever =>
        const MapLocationBannerContent(
          title: 'Permiso bloqueado',
          message:
              'Habilita la ubicación para HydroAlert desde los ajustes del '
              'dispositivo.',
          actionLabel: 'Abrir ajustes',
        ),
      LocationAvailability.ready => const MapLocationBannerContent(
        title: '',
        message: '',
        actionLabel: '',
      ),
    };
  }
}

/// Dismissible warning that explains why the user location is unavailable and
/// offers the matching way to fix it.
class MapLocationBanner extends StatelessWidget {
  const MapLocationBanner({
    super.key,
    required this.availability,
    required this.onResolve,
    required this.onDismiss,
  });

  final LocationAvailability availability;
  final VoidCallback onResolve;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final content = MapLocationBannerContent.from(availability);

    return InfoBanner(
      icon: LucideIcons.mapPinOff,
      tone: InfoBannerTone.warning,
      title: content.title,
      message: content.message,
      actionLabel: content.actionLabel,
      onAction: onResolve,
      onDismiss: onDismiss,
    );
  }
}

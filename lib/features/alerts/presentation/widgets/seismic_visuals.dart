import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/seismic_event.dart';

Color seismicColorFor(double magnitude) {
  if (magnitude >= 6.0) {
    return AppColors.seismicMajor;
  }
  if (magnitude >= 5.0) {
    return AppColors.seismicStrong;
  }
  if (magnitude >= 4.0) {
    return AppColors.seismicModerate;
  }
  return AppColors.seismicLow;
}

String seismicLevelLabel(double magnitude) {
  if (magnitude >= 6.0) {
    return 'Mayor';
  }
  if (magnitude >= 5.0) {
    return 'Fuerte';
  }
  if (magnitude >= 4.0) {
    return 'Moderado';
  }
  return 'Leve';
}

String reviewStatusLabel(SeismicEvent event) {
  final status = event.reviewStatus?.trim().toLowerCase();
  if (event.source.toUpperCase() == 'INETER') {
    return switch (status) {
      'c' => 'Confirmado por INETER',
      'a' => 'Detección automática',
      _ => 'Reportado por INETER',
    };
  }

  return switch (status) {
    'reviewed' => 'Revisado por USGS',
    'automatic' => 'Detección automática',
    'deleted' => 'Evento retirado',
    _ => 'Estado no disponible',
  };
}

String seismicSourceLabel(SeismicEvent event) {
  return 'Fuente: ${event.source}';
}

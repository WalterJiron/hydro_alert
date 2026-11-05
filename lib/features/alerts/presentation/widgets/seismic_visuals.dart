import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

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

String reviewStatusLabel(String? status) {
  return switch (status?.toLowerCase()) {
    'reviewed' => 'Revisado por USGS',
    'automatic' => 'Detección automática',
    'deleted' => 'Evento retirado',
    _ => 'Estado no disponible',
  };
}

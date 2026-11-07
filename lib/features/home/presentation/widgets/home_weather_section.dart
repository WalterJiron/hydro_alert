import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../alerts/domain/entities/weather_snapshot.dart';
import '../../../alerts/presentation/viewmodels/weather_viewmodel.dart';
import '../../../alerts/presentation/widgets/weather_snapshot_card.dart';
import 'home_unavailable_card.dart';

/// Current weather block of the home dashboard.
class HomeWeatherSection extends ConsumerWidget {
  const HomeWeatherSection({super.key, required this.weather});

  final AsyncValue<WeatherSnapshot> weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!AppConfig.hasWeather) {
      return const HomeUnavailableCard(
        icon: LucideIcons.cloudSun,
        title: 'Clima no disponible',
        message:
            'La información meteorológica se activará cuando se configure '
            'la clave de WeatherAPI en esta compilación.',
      );
    }

    return weather.when(
      loading: () => const AppCard(
        child: LoadingState(message: 'Consultando el clima…', compact: true),
      ),
      error: (error, stackTrace) {
        return HomeUnavailableCard(
          icon: LucideIcons.cloudSun,
          title: 'Clima no disponible',
          message: error is ConfigurationFailure
              ? 'La información meteorológica se activará cuando se configure '
                    'la clave de WeatherAPI en esta compilación.'
              : errorMessageOf(error),
          onRetry: error is ConfigurationFailure
              ? null
              : () => ref.read(weatherViewModelProvider.notifier).refresh(),
        );
      },
      data: (snapshot) => WeatherSnapshotCard(snapshot: snapshot),
    );
  }
}

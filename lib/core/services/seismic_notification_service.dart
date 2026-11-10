import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/alerts/domain/entities/seismic_event.dart';

const _kChannelId = 'hydroalert_seismic';
const _kChannelName = 'Alertas sísmicas';
const _kChannelDescription =
    'Notificaciones de sismos de magnitud significativa detectados por INETER.';
const _kBaseNotificationId = 1000;

class SeismicNotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _disposed = false;

  Future<void> initialize() async {
    if (_initialized || _disposed) return;

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
      macOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    try {
      await _plugin.initialize(initSettings);

      const channel = AndroidNotificationChannel(
        _kChannelId,
        _kChannelName,
        description: _kChannelDescription,
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      );

      final androidImpl = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await androidImpl?.createNotificationChannel(channel);
      await androidImpl?.requestNotificationsPermission();

      _initialized = true;
    } catch (error) {
      debugPrint('[SeismicNotificationService] init error: $error');
    }
  }

  Future<void> showSeismicAlert(SeismicEvent event) async {
    if (!_initialized || _disposed) return;

    final notificationId = _kBaseNotificationId + (event.id.hashCode % 9000);

    try {
      await _plugin.show(
        notificationId,
        'Sismo M${event.magnitudeLabel} — ${event.place}',
        'Magnitud ${event.magnitudeLabel} · ${event.depthLabel} · '
            'Fuente: ${event.source}',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _kChannelId,
            _kChannelName,
            channelDescription: _kChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            ticker: 'Alerta sísmica',
            enableVibration: true,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    } catch (error) {
      debugPrint('[SeismicNotificationService] show error: $error');
    }
  }

  void dispose() => _disposed = true;
}

final seismicNotificationServiceProvider = Provider<SeismicNotificationService>(
  (ref) {
    final service = SeismicNotificationService();
    ref.onDispose(service.dispose);
    return service;
  },
);

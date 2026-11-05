import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/config/app_config.dart';
import 'push_emergency_message.dart';

/// Top-level handler registered before `runApp`.
///
/// The OS displays the notification when the app is in the background. When
/// the user opens it, `onMessageOpenedApp` or `getInitialMessage` emits the
/// emergency event into the app.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (!AppConfig.firebaseEnabled) {
    return;
  }

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (error) {
    debugPrint('No se pudo inicializar Firebase en segundo plano: $error');
  }
}

/// Firebase Cloud Messaging integration.
///
/// Initialization is opt-in through `--dart-define=FIREBASE_ENABLED=true`.
/// Without the native Firebase configuration files the app continues to work
/// and this service stays disabled.
class NotificationService {
  final StreamController<PushEmergencyMessage> _emergencyController =
      StreamController<PushEmergencyMessage>.broadcast();

  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _openedSubscription;
  bool _initialized = false;
  bool _disposed = false;

  Stream<PushEmergencyMessage> get emergencyMessages =>
      _emergencyController.stream;

  FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  Future<void> initialize() async {
    if (_initialized || _disposed || !AppConfig.firebaseEnabled) {
      return;
    }

    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      await _messaging.requestPermission(alert: true, badge: true, sound: true);

      _foregroundSubscription = FirebaseMessaging.onMessage.listen(
        _handleForegroundMessage,
      );
      _openedSubscription = FirebaseMessaging.onMessageOpenedApp.listen(
        _handleOpenedMessage,
      );

      final initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleOpenedMessage(initialMessage);
      }

      _initialized = true;
    } catch (error) {
      debugPrint(
        'Firebase no está configurado o no pudo inicializarse: $error',
      );
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    final emergency = _toEmergency(message);
    if (emergency != null && !_emergencyController.isClosed) {
      _emergencyController.add(emergency);
    }
  }

  void _handleOpenedMessage(RemoteMessage message) {
    final emergency = _toEmergency(message);
    if (emergency != null && !_emergencyController.isClosed) {
      _emergencyController.add(emergency);
    }
  }

  PushEmergencyMessage? _toEmergency(RemoteMessage message) {
    final data = message.data;
    final type = (data['type'] ?? '').toString().toLowerCase();
    final priority = (data['priority'] ?? '').toString().toLowerCase();
    final isEmergency =
        type == 'emergency' ||
        priority == 'critical' ||
        data['emergency'] == 'true' ||
        data['emergency'] == true;

    if (!isEmergency) {
      return null;
    }

    final receivedAt = message.sentTime ?? DateTime.now();
    final notification = message.notification;

    return PushEmergencyMessage(
      id:
          data['eventId']?.toString() ??
          message.messageId ??
          'push-${receivedAt.millisecondsSinceEpoch}',
      title:
          notification?.title ??
          data['title']?.toString() ??
          'Notificación de emergencia',
      body:
          notification?.body ??
          data['body']?.toString() ??
          'Recibiste una notificación de emergencia de HydroAlert.',
      receivedAt: receivedAt,
      magnitude: double.tryParse(data['magnitude']?.toString() ?? ''),
      place: data['place']?.toString(),
      latitude: double.tryParse(data['latitude']?.toString() ?? ''),
      longitude: double.tryParse(data['longitude']?.toString() ?? ''),
      externalUrl: data['url']?.toString(),
    );
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _foregroundSubscription?.cancel();
    _openedSubscription?.cancel();
    _emergencyController.close();
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final service = NotificationService();
  ref.onDispose(service.dispose);
  return service;
});

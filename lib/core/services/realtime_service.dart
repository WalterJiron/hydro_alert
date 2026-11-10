import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../app/config/app_config.dart';
import '../../app/constants/api_endpoints.dart';
import 'push_emergency_message.dart';

enum RealtimeReportEventType { created, deleted, resyncRequired }

class RealtimeReportEvent {
  const RealtimeReportEvent.created(this.reportId)
    : type = RealtimeReportEventType.created;

  const RealtimeReportEvent.deleted(this.reportId)
    : type = RealtimeReportEventType.deleted;

  const RealtimeReportEvent.resyncRequired()
    : type = RealtimeReportEventType.resyncRequired,
      reportId = null;

  final RealtimeReportEventType type;
  final String? reportId;
}

/// Realtime channel for community reports and emergency notifications.
///
/// Connects to `{API_BASE_URL}/ws?channels=reports,notifications`, sends a
/// ping every 30 seconds, resumes with `lastEventId`, and reconnects with
/// exponential backoff. No token is required.
class RealtimeService {
  RealtimeService({Uri? uri})
    : _baseUri = uri ?? AppConfig.realtimeWebSocketUri;

  final Uri? _baseUri;
  final StreamController<RealtimeReportEvent> _reportController =
      StreamController<RealtimeReportEvent>.broadcast();
  final StreamController<PushEmergencyMessage> _notificationController =
      StreamController<PushEmergencyMessage>.broadcast();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  Timer? _pingTimer;
  Timer? _reconnectTimer;
  String? _lastEventId;
  int _attempt = 0;
  bool _started = false;
  bool _connecting = false;
  bool _disposed = false;

  Stream<RealtimeReportEvent> get reportEvents => _reportController.stream;

  Stream<PushEmergencyMessage> get notificationEvents =>
      _notificationController.stream;

  void start() {
    if (_started || _disposed) {
      return;
    }
    _started = true;
    _connect();
  }

  void _connect() {
    if (_disposed || _connecting || _channel != null) {
      return;
    }

    final base = _baseUri;
    if (base == null) {
      return;
    }

    _connecting = true;
    try {
      final queryParameters = <String, String>{
        'channels': ApiEndpoints.realtimeChannels,
      };
      final lastEventId = _lastEventId;
      if (lastEventId != null) {
        queryParameters['lastEventId'] = lastEventId;
      }
      final uri = base.replace(queryParameters: queryParameters);
      final channel = WebSocketChannel.connect(uri);
      _channel = channel;
      _subscription = channel.stream.listen(
        _handleMessage,
        onError: (Object error, StackTrace stackTrace) => _handleDisconnect(),
        onDone: _handleDisconnect,
        cancelOnError: false,
      );
      unawaited(_awaitReady(channel));
    } catch (_) {
      _handleDisconnect();
    } finally {
      _connecting = false;
    }
  }

  Future<void> _awaitReady(WebSocketChannel channel) async {
    try {
      await channel.ready;
      if (_disposed || _channel != channel) {
        return;
      }
      _attempt = 0;
      _pingTimer?.cancel();
      _pingTimer = Timer.periodic(
        const Duration(seconds: 30),
        (_) => _sendPing(),
      );
    } catch (_) {
      _handleDisconnect();
    }
  }

  void _handleMessage(dynamic raw) {
    if (_disposed || raw is! String) {
      return;
    }

    final Map<String, dynamic> message;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return;
      }
      message = Map<String, dynamic>.from(decoded);
    } catch (_) {
      return;
    }

    final eventId = _asString(message['id']);
    if (eventId != null) {
      _lastEventId = eventId;
    }

    final event = _asString(message['event']);
    final data = message['data'];
    switch (event) {
      case 'connection.ready':
        _attempt = 0;
        if (data is Map && data['resumed'] == false) {
          _reportController.add(const RealtimeReportEvent.resyncRequired());
        }
      case 'report.created':
        if (data is Map) {
          _reportController.add(
            RealtimeReportEvent.created(_asString(data['id'])),
          );
        }
      case 'report.deleted':
        if (data is Map) {
          _reportController.add(
            RealtimeReportEvent.deleted(_asString(data['id'])),
          );
        }
      case 'notification.created':
        if (data is Map) {
          final notification = _parseNotification(
            Map<String, dynamic>.from(data),
            envelopeId: eventId,
          );
          if (notification != null) {
            _notificationController.add(notification);
          }
        }
      case 'error':
        if (data is Map && data['retryable'] == false) {
          _reportController.add(const RealtimeReportEvent.resyncRequired());
        }
      case 'pong':
      default:
        break;
    }
  }

  PushEmergencyMessage? _parseNotification(
    Map<String, dynamic> data, {
    String? envelopeId,
  }) {
    final eventId = _asString(data['eventId']) ?? envelopeId;
    if (eventId == null) {
      return null;
    }

    final sentTime = _parseDateTime(data['sentTime']);
    return PushEmergencyMessage(
      id: eventId,
      title: _asString(data['title']) ?? 'Alerta de emergencia',
      body:
          _asString(data['body']) ??
          'Se detectó un evento sísmico fuerte. Sigue las indicaciones de las autoridades.',
      receivedAt: sentTime?.toLocal() ?? DateTime.now(),
      magnitude: _asDouble(data['magnitude']),
      place: _asString(data['place']),
      latitude: _asDouble(data['latitude']),
      longitude: _asDouble(data['longitude']),
      externalUrl: _asString(data['url']),
    );
  }

  void _sendPing() {
    final channel = _channel;
    if (channel == null || _disposed) {
      return;
    }

    try {
      channel.sink.add(
        jsonEncode(<String, dynamic>{
          'action': 'ping',
          'sentAt': DateTime.now().toUtc().toIso8601String(),
        }),
      );
    } catch (_) {
      _handleDisconnect();
    }
  }

  void _handleDisconnect() {
    if (_disposed) {
      return;
    }

    _pingTimer?.cancel();
    _pingTimer = null;
    final subscription = _subscription;
    _subscription = null;
    unawaited(subscription?.cancel());
    final channel = _channel;
    _channel = null;
    if (channel != null) {
      unawaited(channel.sink.close());
    }

    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_disposed || !_started || _reconnectTimer?.isActive == true) {
      return;
    }

    final seconds = (2 << _attempt).clamp(2, 30).toInt();
    _attempt = (_attempt + 1).clamp(0, 4).toInt();
    _reconnectTimer = Timer(Duration(seconds: seconds), () {
      _reconnectTimer = null;
      _connect();
    });
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _started = false;
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    unawaited(_subscription?.cancel());
    _subscription = null;
    final channel = _channel;
    _channel = null;
    if (channel != null) {
      unawaited(channel.sink.close());
    }
    unawaited(_reportController.close());
    unawaited(_notificationController.close());
  }

  static String? _asString(Object? value) {
    return value is String && value.trim().isNotEmpty ? value.trim() : null;
  }

  static double? _asDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  static DateTime? _parseDateTime(Object? value) {
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}

final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  final service = RealtimeService();
  ref.keepAlive();
  ref.onDispose(service.dispose);
  return service;
});

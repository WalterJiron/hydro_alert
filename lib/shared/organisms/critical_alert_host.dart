import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/notification_service.dart';
import '../../core/services/push_emergency_message.dart';
import '../../core/services/realtime_service.dart';
import '../../core/services/seismic_notification_service.dart';
import '../../features/alerts/presentation/viewmodels/alerts_viewmodel.dart';
import '../../features/emergency_sos/presentation/viewmodels/emergency_viewmodel.dart';
import '../../features/emergency_sos/presentation/views/critical_alert_overlay_view.dart';

/// Hosts the critical alert overlay above every route and links INETER events,
/// realtime notifications and push messages to the emergency view model.
class CriticalAlertHost extends ConsumerStatefulWidget {
  const CriticalAlertHost({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<CriticalAlertHost> createState() => _CriticalAlertHostState();
}

class _CriticalAlertHostState extends ConsumerState<CriticalAlertHost> {
  StreamSubscription<PushEmergencyMessage>? _pushSubscription;
  StreamSubscription<PushEmergencyMessage>? _realtimeSubscription;

  @override
  void initState() {
    super.initState();
    final notifications = ref.read(notificationServiceProvider);
    _pushSubscription = notifications.emergencyMessages.listen((message) {
      if (!mounted) {
        return;
      }
      ref.read(emergencyViewModelProvider.notifier).triggerPush(message);
    });
    unawaited(notifications.initialize());

    unawaited(ref.read(seismicNotificationServiceProvider).initialize());

    final realtime = ref.read(realtimeServiceProvider);
    _realtimeSubscription = realtime.notificationEvents.listen((message) {
      if (!mounted) {
        return;
      }
      ref.read(emergencyViewModelProvider.notifier).triggerPush(message);
    });
    realtime.start();
  }

  @override
  void dispose() {
    _pushSubscription?.cancel();
    _realtimeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(alertsViewModelProvider, (previous, next) {
      final events = next.value;
      if (events == null || events.isEmpty) {
        return;
      }
      ref
          .read(emergencyViewModelProvider.notifier)
          .evaluateSeismicEvents(events);
    });

    final emergency = ref.watch(emergencyViewModelProvider);

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            ignoring: emergency == null,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: emergency == null
                  ? const SizedBox.shrink()
                  : CriticalAlertOverlayView(
                      key: ValueKey(emergency.id),
                      event: emergency,
                      onDismiss: () {
                        ref.read(emergencyViewModelProvider.notifier).dismiss();
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

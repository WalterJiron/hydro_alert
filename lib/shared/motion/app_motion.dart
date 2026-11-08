import 'package:flutter/widgets.dart';

/// Central motion tokens so every screen animates with the same rhythm.
///
/// Effects must stay short and one-shot. Infinite animations are reserved for
/// the critical SOS overlay, where motion communicates urgency.
class AppMotion {
  const AppMotion._();

  static const Duration press = Duration(milliseconds: 120);
  static const Duration quick = Duration(milliseconds: 180);
  static const Duration standard = Duration(milliseconds: 320);
  static const Duration emphasized = Duration(milliseconds: 480);

  /// Delay applied per item when a list enters with a stagger.
  static const Duration stagger = Duration(milliseconds: 70);

  /// Caps the accumulated delay so long lists do not feel slow.
  static const int maxStaggerOrder = 8;

  static const Curve curve = Curves.easeOutCubic;
  static const Curve emphasizedCurve = Curves.easeOutQuint;

  /// Users who disabled system animations get static content.
  static bool isReduced(BuildContext context) {
    return MediaQuery.maybeOf(context)?.disableAnimations ?? false;
  }

  static Duration resolve(BuildContext context, Duration duration) {
    return isReduced(context) ? Duration.zero : duration;
  }

  static Duration delayFor(int order) {
    return stagger * order.clamp(0, maxStaggerOrder);
  }
}

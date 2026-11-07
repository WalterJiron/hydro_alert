import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'app_motion.dart';

/// One-shot fade, slide and optional scale used when a block enters the screen.
///
/// Pass a small [order] for list items or stacked sections so they cascade
/// without accumulating delays beyond [AppMotion.maxStaggerOrder].
class AppAnimatedEntrance extends StatelessWidget {
  const AppAnimatedEntrance({
    super.key,
    required this.child,
    this.order = 0,
    this.offset = const Offset(0, 0.06),
    this.duration = AppMotion.standard,
    this.curve = AppMotion.curve,
    this.fromScale,
  });

  final Widget child;
  final int order;
  final Offset offset;
  final Duration duration;
  final Curve curve;
  final double? fromScale;

  @override
  Widget build(BuildContext context) {
    if (AppMotion.isReduced(context)) {
      return child;
    }

    var animated = child
        .animate(delay: AppMotion.delayFor(order))
        .fadeIn(duration: duration, curve: curve)
        .slide(
          begin: offset,
          end: Offset.zero,
          duration: duration,
          curve: curve,
        );

    final scale = fromScale;
    if (scale != null) {
      animated = animated.scale(
        begin: Offset(scale, scale),
        end: const Offset(1, 1),
        duration: duration,
        curve: curve,
      );
    }

    return animated;
  }
}

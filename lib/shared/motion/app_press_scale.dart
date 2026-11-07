import 'package:flutter/material.dart';

import 'app_motion.dart';

/// Subtle press feedback for cards and primary actions.
///
/// [Listener] is used on purpose: it observes pointers without competing with
/// the [InkWell] or button gesture that lives inside the child.
class AppPressScale extends StatefulWidget {
  const AppPressScale({
    super.key,
    required this.child,
    this.enabled = true,
    this.pressedScale = 0.975,
  });

  final Widget child;
  final bool enabled;
  final double pressedScale;

  @override
  State<AppPressScale> createState() => _AppPressScaleState();
}

class _AppPressScaleState extends State<AppPressScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled || _pressed == value) {
      return;
    }
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final scale = !widget.enabled || AppMotion.isReduced(context)
        ? 1.0
        : (_pressed ? widget.pressedScale : 1.0);

    return Listener(
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: scale,
        duration: AppMotion.press,
        curve: AppMotion.curve,
        child: widget.child,
      ),
    );
  }
}

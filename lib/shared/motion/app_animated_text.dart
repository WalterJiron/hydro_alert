import 'package:flutter/material.dart';

import 'app_animated_switcher.dart';

/// Text that cross-fades when its value changes, without reflowing the layout.
class AppAnimatedText extends StatelessWidget {
  const AppAnimatedText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppAnimatedSwitcher(
      child: Text(
        text,
        key: ValueKey(text),
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}

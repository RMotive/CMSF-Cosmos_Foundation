import 'package:flutter/material.dart';

class ColoredSizedbox extends StatelessWidget {
  final Color backgroundColor;
  final Size boxSize;

  const ColoredSizedbox({
    super.key,
    required this.backgroundColor,
    required this.boxSize,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: SizedBox(
        width: boxSize.width,
        height: boxSize.height,
      ),
    );
  }
}

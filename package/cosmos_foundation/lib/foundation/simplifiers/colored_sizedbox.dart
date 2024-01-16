import 'package:flutter/material.dart';

class CosmosColorBox extends StatelessWidget {
  final Color color;
  final Size size;
  final Widget? child;

  const CosmosColorBox({
    super.key,
    this.child,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CosmosColorBox extends StatelessWidget {
  final Color backgroundColor;
  final Size boxSize;

  const CosmosColorBox({
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

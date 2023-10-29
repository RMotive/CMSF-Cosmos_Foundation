import 'package:flutter/material.dart';

class SeparatorRow extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final VerticalDirection verticalDirection;
  final MainAxisSize mainAxisSize;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;
  final List<Widget> children;
  final bool includeStart;
  final bool includeEnd;
  final double spacing;
  const SeparatorRow({
    super.key,
    required this.children,
    required this.spacing,
    this.textBaseline,
    this.textDirection,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.includeEnd = false,
    this.includeStart = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: [
        if (includeStart)
          SizedBox.square(
            dimension: spacing,
          ),
        for (Widget item in children) ...{
          if (!(children.indexOf(item) == 0))
            SizedBox.square(
              dimension: spacing,
            ),
          item,
        },
        if (includeEnd)
          SizedBox.square(
            dimension: spacing,
          )
      ],
    );
  }
}

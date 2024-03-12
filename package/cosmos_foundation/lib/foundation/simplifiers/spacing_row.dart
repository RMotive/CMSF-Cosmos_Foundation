import 'package:flutter/material.dart';

class SpacingRow extends StatelessWidget {
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
  const SpacingRow({
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
      children: <Widget>[
        if (includeStart)
          SizedBox.square(
            dimension: spacing,
          ),
        for (int i = 0; i < children.length; i++) ...<Widget>{
          if (i != 0)
            SizedBox.square(
              dimension: spacing,
            ),
          children[i],
        },
        if (includeEnd)
          SizedBox.square(
            dimension: spacing,
          )
      ],
    );
  }
}

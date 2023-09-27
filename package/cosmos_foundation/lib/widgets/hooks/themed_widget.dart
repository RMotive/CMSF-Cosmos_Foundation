import 'package:flutter/material.dart';

class ThemedWidget extends StatelessWidget {
  final Widget Function(BuildContext, ThemeData) builder;

  const ThemedWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (newestContext) {
        return builder(
          context,
          Theme.of(newestContext),
        );
      },
    );
  }
}

import 'package:flutter/widgets.dart';

/// Hook widget from [CosmosFoundation] that builds your UI depending on the surface available.
class ResponsiveView extends StatelessWidget {
  /// This view will be shown when the screen width is >= 1024
  final Widget onLarge;

  /// This view will be shown when the screen width is >= 600 and < 1024
  final Widget? onMedium;

  /// This view will be shown when the screen width is < 600
  final Widget onSmall;

  const ResponsiveView({
    super.key,
    required this.onLarge,
    required this.onSmall,
    this.onMedium,
  });

  @override
  Widget build(BuildContext context) {
    Size viewSurface = MediaQuery.sizeOf(context);

    if (viewSurface.width < 600) return onSmall;
    if (viewSurface.width < 1024) return onMedium ?? onLarge;
    return onLarge;
  }
}

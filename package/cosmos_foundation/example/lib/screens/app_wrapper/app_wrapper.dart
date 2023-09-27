import 'package:cosmos_foundation/widgets/conditionals/platform_condition_widget.dart';
import 'package:example/main.dart';
import '../platform_condition_widget/platform_condition_widget_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// --> Mobile parting
part './mobile/mobile_app_wrapper.dart';
part './mobile/widgets/mobile_app_bar.dart';
part './mobile/widgets/mobile_app_drawer.dart';

class AppWrapper extends StatelessWidget {
  final Widget screen;

  const AppWrapper({
    super.key,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PlatformConditionWidget(
      mobileValue: _MobileWrapper(
        theme: theme,
        child: screen,
      ),
    );
  }
}

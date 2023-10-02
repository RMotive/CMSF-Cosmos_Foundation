import 'package:cosmos_foundation/helpers/theme.dart';
import 'package:cosmos_foundation/widgets/hooks/cosmos_app.dart';
import 'package:example/dark_theme.dart';
import 'package:example/light_theme.dart';
import 'package:example/theme_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final ValueListenable<ThemeMode> themeHandler = ValueNotifier<ThemeMode>(ThemeMode.dark);
final GlobalKey<NavigatorState> navigatorHandler = GlobalKey();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CosmosApp(
      listenFrameSize: true,
      defaultTheme: LightTheme(),
      homeWidget: ColoredBox(
        color: Colors.red,
        child: SizedBox(),
      ),
    );
  }
}

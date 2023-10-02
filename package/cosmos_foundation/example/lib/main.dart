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
    return CosmosApp(
      defaultTheme: const LightTheme(),
      homeBuilder: (context) {
        ThemeBase theme = getTheme();

        return Center(
          child: ColoredBox(
            color: theme.primaryColor,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    updateTheme(const DarkTheme());
                  },
                  style: const ButtonStyle(),
                  child: const Text("press"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

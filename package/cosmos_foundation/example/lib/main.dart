import 'package:cosmos_foundation/widgets/conditionals/platform_condition_widget.dart';
import 'package:example/screens/app_wrapper/app_wrapper.dart';
import 'package:example/screens/welcome_package_screen.dart';
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
    return ValueListenableBuilder(
      valueListenable: themeHandler,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: value,
          navigatorKey: navigatorHandler,
          routes: <String, Widget Function(BuildContext)>{
            '/platform-conditional-widget': (p0) => const PlatformConditionWidget(),
          },
          home: const WelcomePackageScreen(),
          builder: (context, child) {
            if (child == null) return ErrorWidget("Critical app wrapper routing resolve");
            return AppWrapper(
              screen: child,
            );
          },
        );
      },
    );
  }
}

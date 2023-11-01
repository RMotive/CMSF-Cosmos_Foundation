import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:cosmos_foundation/widgets/hooks/cosmos_app.dart';
import 'package:cosmos_foundation/widgets/hooks/cosmos_route.dart';
import 'package:cosmos_foundation/widgets/hooks/cosmos_routing.dart';
import 'package:example/config/theme/light_theme.dart';
import 'package:example/config/theme/theme_base.dart';
import 'package:example/screens/package_home_screen.dart';
import 'package:example/screens/routing_testing_buttons.dart';
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
    return CosmosApp<ThemeBase>.router(
      listenFrameSize: true,
      defaultTheme: const LightTheme(),
      routerConfig: CosmosRouting(
        routes: <CosmosRouteBase>[
          CosmosRoute(
            const RouteOptions('/'),
            build: (BuildContext ctx) => const PackageHomeScreen(),
          ),
          CosmosRoute(
            const RouteOptions('/hello'),
            build: (BuildContext ctx) => const RoutingTestingButtons(),
          ),
        ],
      ),
    );
  }
}

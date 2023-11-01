import 'package:cosmos_foundation/contracts/cosmos_route.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/foundation/configurations/cosmos_routing.dart';
import 'package:cosmos_foundation/foundation/hooks/cosmos_app.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:example/config/routes/routes.dart';
import 'package:example/config/theme/light_theme.dart';
import 'package:example/config/theme/theme_base.dart';
import 'package:example/screens/init_page.dart';
import 'package:example/screens/bluegrey_page.dart';
import 'package:example/screens/teal_page.dart';
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
            initRoute,
            build: (BuildContext ctx, _) => const InitPage(),
          ),
          CosmosRoute(
            yellowRoute,
            subRoutes: <CosmosRoute>[
              CosmosRoute(
                tealRoute,
                build: (BuildContext ctx, RouteOutput output) => const TealPage(),
              )
            ],
            build: (BuildContext ctx, _) => const BluegreyPage(),
          ),
        ],
      ),
    );
  }
}

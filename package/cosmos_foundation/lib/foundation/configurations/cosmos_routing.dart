import 'dart:async';

import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/extensions/int_extension.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cosmos_foundation/helpers/route_driver.dart';

final RouteDriver _routeDriver = RouteDriver.i;

/// This hook provides an abstracted interface for routing between GoRouter and Cosmos Foundation internal utilities initializations, by that, this
/// interfaced hook should be forced.
class CosmosRouting extends GoRouter {
  CosmosRouting({
    required List<CosmosRouteBase> routes,
    FutureOr<RouteOptions?> Function(BuildContext, RouteOutput)? redirect,
    GlobalKey<NavigatorState>? navigator,
  }) : super.routingConfig(
          navigatorKey: navigator ?? GlobalKey<NavigatorState>(),
          routingConfig: _HookedListener(
            RoutingConfig(
              routes: <RouteBase>[
                for (CosmosRouteBase routeBase in routes) routeBase.compose(),
              ],
              redirect: (BuildContext context, GoRouterState state) async {
                RouteDriver.initRouteTree(routes);
                if (redirect == null) return null;

                RouteOutput output = RouteOutput.fromGo(state);
                RouteOptions? route = await redirect.call(context, output);
                if (route == null) return null;
                String? absolutePath = _routeDriver.calculateAbsolutePath(route);
                return absolutePath;
              },
            ),
          ),
        ) {
    Future<void>.delayed(
      120.miliseconds,
      () => RouteDriver.initNavigator(super.configuration.navigatorKey),
    );
  }
}

class _HookedListener extends ValueListenable<RoutingConfig> {
  const _HookedListener(this.value);

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  final RoutingConfig value;
}

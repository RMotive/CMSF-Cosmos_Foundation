import 'dart:async';

import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:cosmos_foundation/helpers/route_driver.dart';


const String kIgnoreRedirectKey = "ignore-redirection-key-2024";
final RouteDriver _routeDriver = RouteDriver.i;
final GlobalKey<NavigatorState> _kDefaultNavigator = GlobalKey<NavigatorState>();
bool _initDriver = false;

/// This hook provides an abstracted interface for routing between GoRouter and Cosmos Foundation internal utilities initializations, by that, this
/// interfaced hook should be forced.
class CosmosRouting extends GoRouter {  
  CosmosRouting({
    RouteOptions? developmentRoute,
    required List<CosmosRouteBase> routes,
    FutureOr<RouteOptions?> Function(BuildContext, RouteOutput)? redirect,
    GlobalKey<NavigatorState>? navigator,
  }) : super.routingConfig(
          navigatorKey: navigator ?? _kDefaultNavigator,
          routingConfig: _HookedListener(
            RoutingConfig(
              routes: <RouteBase>[
                for (CosmosRouteBase routeBase in routes) routeBase.compose(),
              ],
              redirect: (BuildContext context, GoRouterState state) async {
                if (!_initDriver) {
                  RouteDriver.initRouteTree(routes);
                  RouteDriver.initNavigator(navigator ?? _kDefaultNavigator);
                  _initDriver = true;
                }

                String currentPath = state.uri.toString();
                String? targetPath = state.fullPath;
                if (developmentRoute != null && targetPath != null) {
                  String? devRouteEvaluation = _routeDriver.evaluteDevRedirection(developmentRoute, currentPath, targetPath);
                  if (devRouteEvaluation != null) return devRouteEvaluation;
                }

                if (redirect == null) return null;
                RouteOptions? calculatedRoute = _routeDriver.calculateRouteOptions(currentPath);
                if (calculatedRoute == null) {
                  throw Exception("Served route doesn't have a valid absolute path calculation and route options subscribed to its request.");
                }
                RouteOutput output = RouteOutput.fromGo(state, calculatedRoute);
                RouteOptions? delegatedRoute = await redirect.call(context, output);
                if (delegatedRoute == null) return null;
                String? calculatedTargetPath = _routeDriver.calculateAbsolutePath(delegatedRoute);
                return calculatedTargetPath;
              },
            ),
          ),
        );
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

import 'dart:async';

import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:cosmos_foundation/helpers/route_driver.dart';

/// --> Internal dependency gather for [RouteDriver].
///
/// Used to get routing features along the main application.
final RouteDriver _routeDriver = RouteDriver.i;

/// Default [NavigatorState] instance to use if the main application doesn't provide one.
final GlobalKey<NavigatorState> _kDefaultNavigator = GlobalKey<NavigatorState>();

/// Indicates wheter the manager already inited the [RouteDriver].
bool _initDriver = false;

/// Indicates the current path reference gathered along routing operations.
String _currentPath = "";

/// This hook provides an abstracted interface for routing between GoRouter and Cosmos Foundation internal utilities initializations, by that, this
/// interfaced hook should be forced.
class CosmosRouting extends GoRouter {
  CosmosRouting({
    RouteOptions? devRoute,
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
                // --> Driver init
                if (!_initDriver) {
                  RouteDriver.initRouteTree(routes);
                  RouteDriver.initNavigator(navigator ?? _kDefaultNavigator);
                  _initDriver = true;
                }
                  
                // --> Evaluating dev route redirect.
                if (devRoute != null && state.fullPath != null) {
                  String? devRedirect = _routeDriver.devRedirect(devRoute, _currentPath, state.fullPath);
                  if (devRedirect != null) {
                    _currentPath = devRedirect;
                    return devRedirect;
                  }
                }
                if (redirect == null) return null;
                
                // --> Evaluate custom redirect injection.
                final String? targetPath = state.fullPath;
                if (targetPath == null) return null;
                final RouteOptions targetOptions = _routeDriver.getOptions(targetPath);
                RouteOutput output = RouteOutput.fromGo(state, targetOptions);
                RouteOptions? redirector = await redirect.call(context, output);
                if (redirector == null) return null;
                String? calculatedTargetPath = _routeDriver.getAbsolute(redirector);
                _currentPath = calculatedTargetPath;
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

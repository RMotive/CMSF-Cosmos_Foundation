import 'dart:async';

import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/contracts/cosmos_layout.dart';
import 'package:cosmos_foundation/helpers/route_driver.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final RouteDriver _routeDriver = RouteDriver.i;

class CosmosRouteLayout extends CosmosRouteBase {
  final GlobalKey<NavigatorState>? innerNavigator;
  final List<NavigatorObserver>? observers;
  final String? restorationScopeId;
  final Page<dynamic> Function(BuildContext ctx, RouteOutput output, Widget page)? layoutTransitionBuild;
  final CosmosLayout Function(BuildContext ctx, RouteOutput output, Widget page)? layoutBuild;
  final FutureOr<RouteOptions> Function(BuildContext ctx, RouteOutput output)? redirect; 

  const CosmosRouteLayout({
    super.parentNavigator,
    super.routes,
    this.innerNavigator,
    this.observers,
    this.restorationScopeId,
    this.layoutBuild,
    this.layoutTransitionBuild,
    this.redirect,
  }) : assert(
          layoutBuild != layoutTransitionBuild,
          'You must provide at least one UI Build (layoutBuild or layoutTransitionBuild) function',
        );

  @override
  RouteBase compose({
    bool isSub = false,
    RouteOptions? developmentRoute,
    bool applicationStart = true,
    FutureOr<RouteOptions?> Function(BuildContext ctx, RouteOutput output)? injectRedirection,
  }) {
    return ShellRoute(
      navigatorKey: innerNavigator,
      observers: observers,
      parentNavigatorKey: parentNavigator,
      restorationScopeId: restorationScopeId ?? GlobalKey().toString(),
      pageBuilder: layoutTransitionBuild == null
          ? null
          : (BuildContext context, GoRouterState state, Widget child) {
              String path = state.uri.toString();
              RouteOptions? route = _routeDriver.calculateRouteOptions(path);
              if (route == null) {
                throw Exception("Served route doesn't have a valid absolute path calculation and route options subscribed to its request.");
              }
              return layoutTransitionBuild!(context, RouteOutput.fromGo(state, route), child);
            },
      builder: layoutBuild == null
          ? null
          : (BuildContext context, GoRouterState state, Widget child) {
              String path = state.uri.toString();
              RouteOptions? route = _routeDriver.calculateRouteOptions(path);
              if (route == null) {
                throw Exception("Served route doesn't have a valid absolute path calculation and route options subscribed to its request.");
              }
              return layoutBuild!(context, RouteOutput.fromGo(state, route), child);
            },
      routes: <RouteBase>[
        for (CosmosRouteBase route in routes)
          route.compose(
            isSub: isSub,
            injectRedirection: injectRedirection,
          ),
      ],
    );
  }
}

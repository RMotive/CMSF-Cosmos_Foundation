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
  final String? restorationScopeId;
  final List<NavigatorObserver>? observers;
  final GlobalKey<NavigatorState>? innerNavigator;
  
  final Page<dynamic> Function(CosmosLayout layout)? transitionBuild;
  final FutureOr<RouteOptions> Function(BuildContext ctx, RouteOutput output)? redirect;
  final CosmosLayout Function(BuildContext ctx, RouteOutput output, Widget page) layoutBuild;

  const CosmosRouteLayout({
    required this.layoutBuild,
    super.parentNavigator,
    super.routes,
    this.innerNavigator,
    this.observers,
    this.restorationScopeId,
    this.transitionBuild,
    this.redirect,
  });

  @override
  RouteBase compose({
    bool isSub = false,
    RouteOptions? developmentRoute,
    bool applicationStart = true,
    FutureOr<RouteOptions?> Function(BuildContext ctx, RouteOutput output)? injectRedirection,
  }) {
    return ShellRoute(
      observers: observers,
      navigatorKey: innerNavigator,
      parentNavigatorKey: parentNavigator,
      restorationScopeId: restorationScopeId ?? GlobalKey().toString(),
      pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
        String path = state.uri.toString();
        RouteOptions route = _routeDriver.getOptions(path);
        CosmosLayout layoutLaid = layoutBuild(context, RouteOutput.fromGo(state, route), child);
        return transitionBuild?.call(layoutLaid) ?? noTransitionPage(layoutLaid);
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

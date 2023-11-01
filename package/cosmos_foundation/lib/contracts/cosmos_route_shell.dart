import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/contracts/cosmos_screen.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CosmosRouteShell extends CosmosRouteBase {
  final GlobalKey<NavigatorState>? innerNavigator;
  final List<NavigatorObserver>? observers;
  final String? restorationScopeId;
  final Page<dynamic> Function(BuildContext ctx, RouteOutput output, Widget page)? pagerBuild;
  final CosmosScreen Function(BuildContext ctx, RouteOutput output, Widget page)? screenBuild;
  final List<CosmosRouteBase> routes;

  const CosmosRouteShell({
    super.parentNavigator,
    required this.routes,
    this.innerNavigator,
    this.observers,
    this.restorationScopeId,
    this.screenBuild,
    this.pagerBuild,
  }) : assert(
          screenBuild != null || pagerBuild != null,
          'You must provide at least one UI Build (screenBuild or pagerBuild) function',
        );

  @override
  RouteBase compose({bool isSub = false}) => ShellRoute(
        navigatorKey: innerNavigator,
        observers: observers,
        parentNavigatorKey: parentNavigator,
        restorationScopeId: restorationScopeId ?? GlobalKey().toString(),
        pageBuilder: pagerBuild != null ? (BuildContext context, GoRouterState state, Widget child) => pagerBuild!(context, RouteOutput.fromGo(state), child) : null,
        builder: screenBuild != null ? (BuildContext context, GoRouterState state, Widget child) => screenBuild!(context, RouteOutput.fromGo(state), child) : null,
        routes: <RouteBase>[
          for (CosmosRouteBase route in routes) route.compose(isSub: isSub),
        ],
      );
}

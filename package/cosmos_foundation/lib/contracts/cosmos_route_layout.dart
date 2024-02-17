import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/contracts/cosmos_layout.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CosmosRouteLayout extends CosmosRouteBase {
  final GlobalKey<NavigatorState>? innerNavigator;
  final List<NavigatorObserver>? observers;
  final String? restorationScopeId;
  final Page<dynamic> Function(BuildContext ctx, RouteOutput output, Widget page)? pageBuild;
  final CosmosLayout Function(BuildContext ctx, RouteOutput output, Widget page)? layoutBuild;

  const CosmosRouteLayout({
    super.parentNavigator,
    super.routes,
    this.innerNavigator,
    this.observers,
    this.restorationScopeId,
    this.layoutBuild,
    this.pageBuild,
  }) : assert(
          layoutBuild != null || pageBuild != null,
          'You must provide at least one UI Build (screenBuild or pagerBuild) function',
        );

  @override
  RouteBase compose({bool isSub = false}) => ShellRoute(
        navigatorKey: innerNavigator,
        observers: observers,
        parentNavigatorKey: parentNavigator,
        restorationScopeId: restorationScopeId ?? GlobalKey().toString(),
        pageBuilder: pageBuild != null ? (BuildContext context, GoRouterState state, Widget child) => pageBuild!(context, RouteOutput.fromGo(state), child) : null,
        builder: layoutBuild != null ? (BuildContext context, GoRouterState state, Widget child) => layoutBuild!(context, RouteOutput.fromGo(state), child) : null,
        routes: <RouteBase>[
          for (CosmosRouteBase route in routes) route.compose(isSub: isSub),
        ],
      );
}

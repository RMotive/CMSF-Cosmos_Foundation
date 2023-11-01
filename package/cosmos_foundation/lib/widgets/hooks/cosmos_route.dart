import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CosmosRoute extends CosmosRouteBase {
  final RouteOptions routeOptions;
  final CosmosPage Function(BuildContext ctx) build;
  final List<CosmosRoute> subRoutes;

  const CosmosRoute(
    this.routeOptions, {
    required this.build,
    this.subRoutes = const <CosmosRoute>[],
  });

  @override
  RouteBase compose() {
    return GoRoute(
      path: routeOptions.path,
      name: routeOptions.name,
      routes: <RouteBase>[
        for (CosmosRoute cr in subRoutes) cr.compose(),
      ],
      builder: (BuildContext context, GoRouterState state) => build(context),
    );
  }
}

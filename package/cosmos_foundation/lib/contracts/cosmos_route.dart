import 'dart:async';

import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A single Route object to indicate the existance of a Route into the Route manager.
/// This means that this object only creates the clnfiguration for handle the redirection/direction of
/// a complex/simple UI Page ([CosmosPage]).
class CosmosRoute extends CosmosRouteBase {
  /// Routing options to handle the location and behavior.
  final RouteOptions routeOptions;

  /// Build function to create the UI Page [CosmosPage] and draw it in the screen.
  final CosmosPage Function(BuildContext ctx, RouteOutput output) build;

  /// Routes below the current Route node.
  /// Note: this don't mean [subRoutes] will be wrapped by this route, this means
  /// that [subRoutes] path will be calculated after this [RouteOptions].
  final List<CosmosRoute> subRoutes;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  final FutureOr<String?> Function(BuildContext ctx, RouteOutput output)? redirect;

  /// Custom Page build for use another animation and page transition options.
  final Page<dynamic> Function(BuildContext ctx, RouteOutput output)? pageBuild;

  final FutureOr<bool> Function(BuildContext ctx)? onExit;

  /// A single Route object to indicate the existance of a Route into the Route manager.
  /// This means that this object only creates the clnfiguration for handle the redirection/direction of
  /// a complex/simple UI Page ([CosmosPage]).
  const CosmosRoute(
    this.routeOptions, {
    super.parentNavigator,
    required this.build,
    this.subRoutes = const <CosmosRoute>[],
    this.redirect,
    this.pageBuild,
    this.onExit,
  });

  @override
  RouteBase compose({bool isSub = false}) {
    String parsedPath = routeOptions.path;
    if (routeOptions.path.startsWith('/')) {
      if (isSub) parsedPath = parsedPath.substring(1, parsedPath.length);
    }

    return GoRoute(
      path: parsedPath,
      name: routeOptions.name,
      parentNavigatorKey: parentNavigator,
      onExit: onExit,
      pageBuilder: pageBuild == null
          ? null
          : (BuildContext context, GoRouterState state) => pageBuild!(
                context,
                RouteOutput.fromGo(state),
              ),
      redirect: redirect == null
          ? null
          : (BuildContext ctx, GoRouterState state) => redirect!(
                ctx,
                RouteOutput.fromGo(state),
              ),
      routes: <RouteBase>[
        for (CosmosRoute cr in subRoutes) cr.compose(isSub: true),
      ],
      builder: (BuildContext context, GoRouterState state) => build(
        context,
        RouteOutput.fromGo(state),
      ),
    );
  }
}

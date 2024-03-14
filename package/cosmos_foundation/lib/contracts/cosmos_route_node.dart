import 'dart:async';

import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/helpers/route_driver.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:cosmos_foundation/models/outputs/route_output.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final RouteDriver _routeDriver = RouteDriver.i;

/// A single Route object to indicate the existance of a Route into the Route manager.
/// This means that this object only creates the clnfiguration for handle the redirection/direction of
/// a complex/simple UI Page ([CosmosPage]).
class CosmosRouteNode extends CosmosRouteBase {
  /// Routing options to handle the location and behavior.
  final RouteOptions routeOptions;

  /// Build function to create the UI Page [CosmosPage] and draw it in the screen.
  final CosmosPage Function(BuildContext ctx, RouteOutput output)? pageBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  final FutureOr<RouteOptions?> Function(BuildContext ctx, RouteOutput output)? redirect;

  /// Custom Page build for use another animation and page transition options.
  final Page<dynamic> Function(BuildContext ctx, RouteOutput output)? pageTransitionBuild;

  final FutureOr<bool> Function(BuildContext ctx)? onExit;

  /// A single Route object to indicate the existance of a Route into the Route manager.
  /// This means that this object only creates the clnfiguration for handle the redirection/direction of
  /// a complex/simple UI Page ([CosmosPage]).
  const CosmosRouteNode(
    this.routeOptions, {
    super.parentNavigator,
    this.pageBuild,
    super.routes,
    this.redirect,
    this.pageTransitionBuild,
    this.onExit,
  }) : assert(
          pageTransitionBuild != pageTransitionBuild,
          'You must provide at least one UI Build (layoutBuild or layoutTransitionBuild) function',
        );

  @override
  RouteBase compose({
    bool isSub = false,
    RouteOptions? developmentRoute,
    bool applicationStart = true,
    FutureOr<RouteOptions?> Function(BuildContext ctx, RouteOutput output)? injectRedirection,
  }) {
    String parsedPath = routeOptions.path;
    if (routeOptions.path.startsWith('/')) {
      if (isSub) parsedPath = parsedPath.substring(1, parsedPath.length);
    }

    return GoRoute(
      path: parsedPath,
      name: routeOptions.name,
      parentNavigatorKey: parentNavigator,
      onExit: onExit,
      pageBuilder: pageTransitionBuild == null
          ? null
          : (BuildContext context, GoRouterState state) => pageTransitionBuild!(
                context,
                RouteOutput.fromGo(state, routeOptions),
              ),
      redirect: (BuildContext ctx, GoRouterState state) async {
        if (_routeDriver.evaluateSubDevRedirection()) {
          return null;
        }        
                
        RouteOutput output = RouteOutput.fromGo(state, routeOptions);
        FutureOr<RouteOptions?>? resultOptions;
        resultOptions = injectRedirection?.call(ctx, output) ?? redirect?.call(ctx, output);
        RouteOptions? calcualtedRedirectionResult = await resultOptions;
        if (calcualtedRedirectionResult == null) return null;
        String? absolutePath = _routeDriver.calculateAbsolutePath(calcualtedRedirectionResult);
        return absolutePath;
      },
      routes: <RouteBase>[
        for (CosmosRouteBase cr in routes) cr.compose(isSub: true),
      ],
      builder: pageBuild == null
          ? null
          : (BuildContext context, GoRouterState state) => pageBuild!(
                context,
                RouteOutput.fromGo(state, routeOptions),
              ),
    );
  }
}

import 'package:cosmos_foundation/contracts/cosmos_route_node.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Creates a contract to ensure a class contains the required properties to work as a Route configurator.
abstract class CosmosRouteBase {
  /// Defines the [NavigatorState] that is upper in the context treee than the current Route in the three.
  /// This works to encapsulate different groups of [Routes] in dedicated [NavigatorState]s.
  final GlobalKey<NavigatorState>? parentNavigator;
  /// Routes below the current Route node.
  /// Note: this don't mean [subRoutes] will be wrapped by this route, this means
  /// that [routes] path will be calculated after this [RouteOptions].
  final List<CosmosRouteBase> routes;

  /// Initializes the abstract properties handler for [CosmosRouteBase]
  const CosmosRouteBase({
    this.parentNavigator,
    this.routes = const <CosmosRouteNode>[],
  });

  /// Compose the current interfaced object [CosmosRouteBase] to a readable [RouteBase] object used by the Router manager
  /// [GoRouter].
  RouteBase compose({bool isSub = false});
}

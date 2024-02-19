import 'package:cosmos_foundation/contracts/cosmos_route_node.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This helper provides several functionallities for Cosmos Foundation routing.
class RouteDriver {
  static NavigatorState? _navigator;
  static NavigatorState get _nav {
    if (_navigator != null) return _navigator as NavigatorState;
    throw Exception('Router helper navigator not initialized, you cannot use this helper yet.');
  }

  static RouteDriver? _instance;
  // Avoid self instance
  RouteDriver._();
  static RouteDriver get i => _instance ??= RouteDriver._();
  

  /// Stores the calculation of absolute paths for the giving routing tree initialized in the application.
  static final Map<int, String> _claculatedAbsolutePaths = <int, String>{};
  /// Stores the reference for an advisor that prints in the context of the manager.
  //static const Advisor _advisor = Advisor('route-driver');

  static void init(GlobalKey<NavigatorState> nav, List<CosmosRouteBase> routes) {
    if (_navigator != null) return;
    _navigator = nav.currentState;
    for (CosmosRouteBase route in routes) {
      _calculateAbsolutePath(route, '');
    }
  }

  static void _calculateAbsolutePath(CosmosRouteBase route, String acumulatedPath) {
    if (route is CosmosRouteNode) {
      RouteOptions routeOptions = route.routeOptions;
      String relativePath = routeOptions.path;
      if (relativePath.startsWith('/')) {
        relativePath = relativePath.replaceFirst('/', '');
      }
      String absolutePath = '$acumulatedPath/$relativePath';
      _claculatedAbsolutePaths[routeOptions.hashCode] = absolutePath;
      acumulatedPath = absolutePath;
    }
    for (CosmosRouteBase routeLeef in route.routes) {
      _calculateAbsolutePath(routeLeef, acumulatedPath);
    }
  }

  void driveTo(RouteOptions options, {bool push = false}) {
    // --> Uncomment when needed, currently is unnecessary cause the RouteOptions object, already adds the hashcode
    // to the name property when it has a unspecified name.
    //
    // int absolutePathKey = options.hashCode;
    // if (!_claculatedAbsolutePaths.containsKey(absolutePathKey)) {
    //   _advisor.adviseWarning(
    //     'This route options doesn\'t have an absolute path calculation',
    //     info: <String, dynamic>{
    //       'current-hashcode': absolutePathKey,
    //       'comment': 'Ensure that you are using the same instance object that you are inserting in the app Route tree',
    //     },
    //   );
    //   return;
    // }
    push ? _nav.context.pushNamed(options.name) : _nav.context.goNamed(options.name);
  }

  String? calculateAbsolutePath(RouteOptions instance) {
    if (!_claculatedAbsolutePaths.containsKey(instance.hashCode)) return null;
    return _claculatedAbsolutePaths[instance.hashCode];
  }

  void removeAll() {
    _nav.popUntil(
      (Route<dynamic> route) => route.isActive,
    );
  }
}

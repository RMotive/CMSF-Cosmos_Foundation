import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_node.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/foundation/configurations/cosmos_routing.dart';
import 'package:cosmos_foundation/helpers/advisor.dart';
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
  static final Map<RouteOptions, String> _calculatedAbsolutePaths = <RouteOptions, String>{};
  /// Stores the reference for an advisor that prints in the context of the manager.
  //static const Advisor _advisor = Advisor('route-driver');

  static bool _isTreeInited = false;

  static const Advisor _advisor = Advisor('route-driver');


  static bool _isDevResolver = false;

  static void initNavigator(GlobalKey<NavigatorState> nav) {
    if (nav.currentState == null) {
      _advisor.adviseWarning('Error, given navigator null');
      return;
    }

    _navigator ??= nav.currentState;
    _advisor.adviseSuccess(
      'Navigator manager successfully inited',
      info: <String, dynamic>{
        'manager-hash': _navigator.hashCode,
      },
    );
  }

  static void initRouteTree(List<CosmosRouteBase> routes) {
    if (_isTreeInited) return;
    for (CosmosRouteBase route in routes) {
      _calculateAbsolutePath(route, '');
    }
    _isTreeInited = true;
  }

  static bool evaluateRedirectionHelp(GoRouterState routingOutput, String key) {
    JObject? extraData = (routingOutput.extra as JObject?);
    if (extraData == null) return false;
    bool? value = extraData[key];
    return value ?? false;
  }

  static void _calculateAbsolutePath(CosmosRouteBase route, String acumulatedPath) {
    if (route is CosmosRouteNode) {
      RouteOptions routeOptions = route.routeOptions;
      String relativePath = routeOptions.path;
      if (relativePath.startsWith('/')) {
        relativePath = relativePath.replaceFirst('/', '');
      }
      String absolutePath = '$acumulatedPath/$relativePath';
      _calculatedAbsolutePaths[routeOptions] = absolutePath;
      acumulatedPath = absolutePath;
    }
    for (CosmosRouteBase routeLeef in route.routes) {
      _calculateAbsolutePath(routeLeef, acumulatedPath);
    }
  }

  void driveTo(
    RouteOptions options, {
    bool ignoreRedirection = false,
    bool push = false,
    JObject? extra,
  }) {
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
    if (ignoreRedirection) {
      extra ??= <String, dynamic>{};
      if (!extra.containsKey(kIgnoreRedirectKey)) {
        extra.addEntries(<MapEntry<String, dynamic>>[const MapEntry<String, dynamic>(kIgnoreRedirectKey, true)]);
      }
    }
    
    if (push) {
      _nav.context.pushNamed(
        options.name,
        extra: extra,
      );
    } else {
      _nav.context.goNamed(
        options.name,
        extra: extra,
      );
    }
    _advisor.adviseSuccess(
      'Success drive',
      info: <String, dynamic>{
        'route-name': options.name,
        'route-extra': extra,
        'context': _nav.context.toString(),
        'push': push,
      },
    );
  }

  String? calculateAbsolutePath(RouteOptions instance) {
    if (!_isTreeInited) {
      _advisor.adviseWarning('Route tree not initialized yet');
      return null;
    }
    if (!_calculatedAbsolutePaths.containsKey(instance)) return null;
    return _calculatedAbsolutePaths[instance];
  }

  RouteOptions? calculateRouteOptions(String absolutePath) {
    for (MapEntry<RouteOptions, String> calculation in _calculatedAbsolutePaths.entries) {
      if (absolutePath == calculation.value) return calculation.key;
    }
    return null;
  }

  String? evaluteDevRedirection(RouteOptions devRoute, String currentPath) {
    if (!_calculatedAbsolutePaths.containsKey(devRoute)) return null;
    String devRoutePath = _calculatedAbsolutePaths[devRoute] as String;
    if (devRoutePath != currentPath) return calculateAbsolutePath(devRoute);
    return null;
  }

  bool evaluateSubDevRedirection() {
    if (_isDevResolver) return false;
    _isDevResolver = true;
    return true;
  }

  void removeAll() {
    _nav.popUntil(
      (Route<dynamic> route) => route.isActive,
    );
  }
}

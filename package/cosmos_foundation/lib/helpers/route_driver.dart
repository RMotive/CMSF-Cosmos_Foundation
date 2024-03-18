import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_node.dart';
import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/foundation/configurations/cosmos_routing.dart';
import 'package:cosmos_foundation/helpers/advisor.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// --> Dependency gather of [Advisor].
///
/// Internal advisor impl to announce [RouteDriver] context messages.
const Advisor _advisor = Advisor('route-driver');

/// This helper provides several functionallities for Cosmos Foundation routing.
class RouteDriver {
  /// Internal reference to look for ignore redirection property in the extra routing info.
  final String _kIgnoreRedirectionKey = "i-r${DateTime.now().toString()}";

  // --> Singleton impl.
  /// --> Already singleton inited object.
  ///
  /// Stores the local static instance of the Manager that will be used along all its invokes.
  static RouteDriver? _instance;
  RouteDriver._();

  /// Gathers the current application [RouteDriver] manager instance.
  ///
  /// If you know it's the first time that you gather this singleton object (init gather), you must invoke
  /// [initNavigator] method to initialize the internal [NavigatorState] to manage the routing, and recommended
  /// if you're using [CosmosRouteBase] invoke [initRouteTree] to initialize the route tree calculation that is a
  /// dependency to the correct functionallity along [CosmosRouteBase] nodes and layouts routing.
  static RouteDriver get i => _instance ??= RouteDriver._();

  /// --> Local manager navigator subscribed along the main application and the driver manager usage.
  ///
  /// This is subscribed after [initNavigator] static method that is already subscribed to the
  /// initialization method of [Cosmos] default application methods, for custom applications
  /// that uses several managers from [Cosmos] nor using [CosmosApp] or [CosmosRouting]. Needs to
  /// invoke the method [initNavigator] to initialize dependencies.
  static GlobalKey<NavigatorState>? _navigator;

  /// --> Local manager navigator subscribed along the main application and the driver manager usage.
  ///
  /// This is subscribed after [initNavigator] static method that is already subscribed to the
  /// initialization method of [Cosmos] default application methods, for custom applications
  /// that uses several managers from [Cosmos] nor using [CosmosApp] or [CosmosRouting]. Needs to
  /// invoke the method [initNavigator] to initialize dependencies.
  static GlobalKey<NavigatorState> get _nav {
    if (_navigator != null) return _navigator as GlobalKey<NavigatorState>;
    throw Exception('NavigatorState dependency lack. Left use of [initNavigator] method');
  }

  /// Stores the calculation of absolute paths for the giving routing tree initialized in the application.
  static final Map<RouteOptions, String> _absoluteContext = <RouteOptions, String>{};

  /// Stores the calculation of absolute paths as a log details object to announce.
  static final Map<String, dynamic> _absoluteContextDetails = <String, dynamic>{};

  /// Indicates wheter internal logging is enabled
  static bool _advisorEnabled = false;

  /// Indicates wheter [initRouteTree] already was called.
  static bool _isTreeInited = false;

  /// Indicates wheter [initNavigator] already was called.
  static bool _isDevResolver = false;

  //* --> Public static methods

  /// Initializes the mandatory dependency for navigation along the router management implementation of your application.
  ///
  /// [nav] : [NavigatorState] that the manager will use along the application to enroute.
  /// [log] : Wheter the method can announce logs.
  static void initNavigator(GlobalKey<NavigatorState> nav, {bool? log}) {
    _navigator ??= nav;
    if (i._canLog(log)) {
      _advisor.adviseSuccess(
        'Navigator inited',
        info: <String, dynamic>{
          'nav-hash': _nav.hashCode,
        },
      );
    }
  }

  /// Initializes the RouteTree used for applications that use [CosmosRouting] impl.
  ///
  /// [routes] : Route tree subscribed to the application routing options that will be used
  /// to calculate the internal route tree for [CosmosRouting] impls.
  /// [log] : Wheter the method can announce logs.
  static void initRouteTree(List<CosmosRouteBase> routes, {bool? log}) {
    if (_isTreeInited) return;
    for (CosmosRouteBase route in routes) {
      _calAbsolute(route, '');
    }
    _isTreeInited = true;
    if (i._canLog(log)) {
      _advisor.adviseSuccess(
        'Successfully route tree inited',
        info: <String, dynamic>{
          'route-tree': _absoluteContext.map(
            (RouteOptions key, String value) {
              return MapEntry<String, dynamic>("(${key.name} | ${key.path} | ${key.hashCode})", value);
            },
          ),
        },
      );
    }
  }

  /// Sets the global context of logs for [RouteDriver] invokes.
  static void turnLogs(bool enable) {
    _advisorEnabled = enable;
  }

  //* --> Public instance methods

  /// Gets the absolute path calculation from a specific [RouteOptions] instance into the calculated Route Tree.
  ///
  /// [instance] : The required [RouteOptions]'s absolute path calculation.
  /// [log] : Wheter the method can announce logs.
  String getAbsolute(RouteOptions instance, {bool? log}) {
    final bool canLog = _canLog(log);
    if (!_isTreeInited) {
      if (canLog) {
        _advisor.adviseWarning('Route tree not initialized yet');
      }
      throw Exception('Route tree not initialized yet');
    }

    if (!_absoluteContext.containsKey(instance)) {
      if (canLog) {
        _advisor.adviseWarning(
          'Route not in route tree',
          info: <String, dynamic>{
            'route': instance,
            'route-tree': _absoluteContextDetails,
          },
        );
      }
      throw Exception('Route not in route tree');
    }
    return _absoluteContext[instance] as String;
  }

  /// Gets the [RouteOptions] from a given absolute path.
  ///
  /// [absolutePath] : Absolute path to get the [RouteOptions].
  /// [log] : Wheter the method can announce logs.
  RouteOptions getOptions(
    String absolutePath, {
    bool? log,
  }) {
    for (MapEntry<RouteOptions, String> calculation in _absoluteContext.entries) {
      if (absolutePath == calculation.value) return calculation.key;
    }

    if (_canLog(log)) {
      _advisor.adviseWarning(
        'Absolute path not in route tree',
        info: <String, dynamic>{
          'absolute-path': absolutePath,
          'route-tree': _absoluteContextDetails,
        },
      );
    }
    throw Exception('Absolute path not in route tree');
  }

  /// Evaluates if the development route redirection should be performed into the master routing redirection.
  ///
  /// [devRoute] : [CosmosRouting] devRoute specified.
  /// [currentPath] : The current application path.
  /// [targetPath] : The target path where the application wants to go.
  String? devRedirect(RouteOptions devRoute, String currentPath, String? targetPath, {bool? log}) {
    if (!_absoluteContext.containsKey(devRoute)) {
      if (_canLog(log)) {
        _advisor.adviseWarning(
          'devRoute not in route tree',
          info: <String, dynamic>{
            'dev-route': devRoute,
            'route-tree': _absoluteContextDetails,
          },
        );
      }
      return null;
    }

    final String devPath = _absoluteContext[devRoute] as String;
    if (currentPath.isEmpty || (devPath == targetPath)) return devPath;
    return null;
  }

  /// Evaluates if the development route redirection should be performed into a node redirection.
  ///
  ///  Notes:
  ///   - Doesn't contain logs.
  bool devRedirectNode() {
    if (_isDevResolver) return false;
    _isDevResolver = true;
    return true;
  }

  /// Routes the application to the desired node.
  ///
  /// [options] : [RouteOptions] to the desired route node target.
  /// [ignoreRedirection] : Indicates if the drive should ignore target node redirection.
  /// [push] : Indicates if the history should push the route.
  /// [extra] : Extra data subscribed to the target route node.
  /// [log] : Wheter the nethod can announce logs.
  void drive(
    RouteOptions options, {
    bool ignoreRedirection = false,
    bool push = false,
    JObject? extra,
    bool? log,
  }) {
    if (ignoreRedirection) {
      extra ??= <String, dynamic>{};
      if (!extra.containsKey(_kIgnoreRedirectionKey)) {
        extra.addEntries(
          <MapEntry<String, dynamic>>[
            MapEntry<String, dynamic>(_kIgnoreRedirectionKey, true),
          ],
        );
      }
    }

    final bool canLog = _canLog(log);
    final NavigatorState? navState = _nav.currentState;
    final BuildContext? navCtx = navState?.context;
    final BuildContext? navigation = _nav.currentContext;

    if (navCtx == null || !navCtx.mounted || navigation == null || !navigation.mounted) {
      if (canLog) {
        _advisor.adviseWarning('Can\'t perform driving cause the Navigator is defunct');
      }
      return;
    }

    if (push) {
      navigation.pushNamed(options.name, extra: extra);
    } else {
      navigation.goNamed(options.name, extra: extra);
    }
    if (canLog) {
      _advisor.adviseSuccess(
        'Success drive',
        info: <String, dynamic>{
          'route-name': options.name,
          'route-extra': extra,
          'context': navigation.hashCode,
          'push': push,
        },
      );
    }
  }

  /// Removes all the route history until the current route node.
  void cleanHistory() {
    _nav.currentState?.popUntil(
      (Route<dynamic> route) => route.isActive,
    );
  }

  //* --> Private static methods

  /// Calculates an absolute path based on the parent absolute path and the current node [RouteOptions].
  ///
  /// [routeNode] : [CosmosRouteBase] where the absolute path is desired.
  /// [parentAbsolute] : The parent node absolute path calculation to join them.
  ///
  /// Notes:
  ///   - Doesn't contain logs.
  static void _calAbsolute(CosmosRouteBase routeNode, String parentAbsolute) {
    if (routeNode is CosmosRouteNode) {
      RouteOptions routeOptions = routeNode.routeOptions;
      String relativePath = routeOptions.path;
      if (relativePath.startsWith('/')) {
        relativePath = relativePath.replaceFirst('/', '');
      }
      String absolutePath = '$parentAbsolute/$relativePath';
      // --> Adding to absolute context
      _absoluteContext[routeOptions] = absolutePath;
      // --> Adding to absolute context details
      _absoluteContextDetails[routeOptions.toString()] = absolutePath;
      parentAbsolute = absolutePath;
    }
    for (CosmosRouteBase routeLeef in routeNode.routes) {
      _calAbsolute(routeLeef, parentAbsolute);
    }
  }

  //* --> Private instance methods.

  /// Evaluates if the method can advise.
  ///
  /// [log] : The method parameter that indicates wheter the method can log (method invokation context).
  bool _canLog(bool? log) {
    if (log == null) return _advisorEnabled;
    return log;
  }
}

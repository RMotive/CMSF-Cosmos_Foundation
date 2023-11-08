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
  static void init(GlobalKey<NavigatorState> nav) => _navigator = nav.currentState;

  void driveTo(RouteOptions options, {bool push = false}) {
    push ? _nav.context.pushNamed(options.name) : _nav.context.goNamed(options.name);
  }

  void removeAll() {
    _nav.popUntil(
      (Route<dynamic> route) => route.isActive,
    );
  }
}

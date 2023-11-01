import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This helper provides several functionallities for Cosmos Foundation routing.
class Router {
  static NavigatorState? _navigator;
  static NavigatorState get _nav {
    if (_navigator != null) return _navigator as NavigatorState;
    throw Exception('Router helper navigator not initialized, you cannot use this helper yet.');
  }

  static Router? _instance;
  // Avoid self instance
  Router._();
  static Router get i => _instance ??= Router._();
  static void init(GlobalKey<NavigatorState> nav) => _navigator = nav.currentState;

  void routeTo(CosmosPage view, {bool push = false}) {
    push ? _nav.context.pushNamed(view.routeOptions.name) : _nav.context.goNamed(view.routeOptions.name);
  }
}

import 'package:cosmos_foundation/helpers/route_driver.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class RouteOutput {
  final RouteOptions route;
  final String absolutePath;
  final ValueKey<String>? pageKey;

  const RouteOutput({
    this.pageKey,
    required this.route,
    required this.absolutePath,
  });
  factory RouteOutput.fromGo(GoRouterState goState, RouteOptions options) {
    String? absolutePath = RouteDriver.i.calculateAbsolutePath(options);

    return RouteOutput(
      route: options,
      pageKey: goState.pageKey,
      absolutePath: absolutePath ?? (goState.uri.toString()),
    );
  }
}

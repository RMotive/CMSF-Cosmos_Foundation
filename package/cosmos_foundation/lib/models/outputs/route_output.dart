import 'package:cosmos_foundation/helpers/route_driver.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:go_router/go_router.dart';

class RouteOutput {
  final RouteOptions route;
  final String absolutePath;

  const RouteOutput({
    required this.route,
    required this.absolutePath,
  });
  factory RouteOutput.fromGo(GoRouterState goState, RouteOptions options) {
    String? absolutePath = RouteDriver.i.calculateAbsolutePath(options);

    return RouteOutput(
      route: options,
      absolutePath: absolutePath ?? (goState.uri.toString()),
    );
  }
}

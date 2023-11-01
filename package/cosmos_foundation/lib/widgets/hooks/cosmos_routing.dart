import 'package:cosmos_foundation/contracts/cosmos_route_base.dart';
import 'package:cosmos_foundation/extensions/int_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cosmos_foundation/helpers/router.dart' as rh;

/// This hook provides an abstracted interface for routing between GoRouter and Cosmos Foundation internal utilities initializations, by that, this
/// interfaced hook should be forced.
class CosmosRouting extends GoRouter {
  CosmosRouting({
    required List<CosmosRouteBase> routes,
    GlobalKey<NavigatorState>? navigator,
  }) : super.routingConfig(
          navigatorKey: navigator ?? GlobalKey<NavigatorState>(),
          routingConfig: _HookedListener(
            RoutingConfig(
              routes: <RouteBase>[
                for (CosmosRouteBase routeBase in routes) routeBase.compose(),
              ],
            ),
          ),
        ) {
    Future<void>.delayed(
      120.miliseconds,
      () => rh.Router.init(super.configuration.navigatorKey),
    );
  }
}

class _HookedListener extends ValueListenable<RoutingConfig> {
  const _HookedListener(this.value);

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  final RoutingConfig value;
}

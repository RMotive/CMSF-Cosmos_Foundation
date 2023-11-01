import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:example/screens/routing_testing_buttons.dart';
import 'package:flutter/material.dart';
import 'package:cosmos_foundation/helpers/router.dart' as hr;

// --> Helpers
final hr.Router _router = hr.Router.i;

class PackageHomeScreen extends CosmosPage {
  const PackageHomeScreen({super.key})
      : super(
          const RouteOptions('/'),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade400,
      child: Center(
        child: FloatingActionButton(
          onPressed: () => _router.routeTo(const RoutingTestingButtons()),
        ),
      ),
    );
  }
}

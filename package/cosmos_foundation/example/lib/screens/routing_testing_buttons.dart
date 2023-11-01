import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/helpers/router.dart' as hr;
import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:example/screens/package_home_screen.dart';
import 'package:flutter/material.dart';

// --> Helpers
final hr.Router _router = hr.Router.i;

class RoutingTestingButtons extends CosmosPage {
  const RoutingTestingButtons({super.key})
      : super(
          const RouteOptions('/hello'),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: FloatingActionButton(
          onPressed: () => _router.routeTo(const PackageHomeScreen()),
        ),
      ),
    );
  }
}

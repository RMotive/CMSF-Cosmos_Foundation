import 'package:cosmos_foundation/models/options/route_options.dart';
import 'package:flutter/material.dart';

abstract class CosmosPage extends StatelessWidget {
  final RouteOptions routeOptions;

  const CosmosPage(
    this.routeOptions, {
    super.key,
  });
}

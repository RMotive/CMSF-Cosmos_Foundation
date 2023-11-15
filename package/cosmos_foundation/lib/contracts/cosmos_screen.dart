import 'package:flutter/material.dart';

/// UI Screen provides a mechanism to wrap a collection of UI Page into a design that doesn't change along the routing of the collection.
abstract class CosmosLayout extends StatelessWidget {
  /// The current UI Page resolved by the router manager.
  final Widget page;

  /// A new [CosmosLayout] contract configuration.
  const CosmosLayout({
    super.key,
    required this.page,
  });
}

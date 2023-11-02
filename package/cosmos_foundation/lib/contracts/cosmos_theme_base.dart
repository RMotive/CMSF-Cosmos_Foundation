import 'package:flutter/material.dart';

abstract class CosmosThemeBase {
  final String themeIdentifier;
  final Color? frameListenerColor;
  const CosmosThemeBase(
    this.themeIdentifier, {
    this.frameListenerColor,
  });
}

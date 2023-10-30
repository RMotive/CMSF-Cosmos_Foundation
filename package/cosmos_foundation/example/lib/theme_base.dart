import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:flutter/material.dart';

class ThemeBase extends CosmosThemeBase {
  final Color primaryColor;
  final Color secondaryColor;
  const ThemeBase(
    super.themeIdentifier, {
    required this.primaryColor,
    required this.secondaryColor,
  });
}

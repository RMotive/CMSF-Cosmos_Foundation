import 'package:flutter/material.dart';

class ThemeColorStruct {
  final Color mainColor;
  final Color onColor;
  final Color? onColorAlt;
  final Color hlightColor;
  final Color? hlightColorAlt;

  const ThemeColorStruct(
    this.mainColor,
    this.onColor,
    this.hlightColor, {
    this.onColorAlt,
    this.hlightColorAlt,
  });
}

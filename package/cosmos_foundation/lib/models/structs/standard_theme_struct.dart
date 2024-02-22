import 'package:flutter/material.dart';

/// Defines a class that handles a bundle of properties used by controls standard theming
class StandardThemeStruct {
  /// Defines the control surface color
  final Color? background;

  /// Defines the inner text color.
  final Color? foreground;

  /// Defines the control border color
  final Color? borderColor;

  /// Defines a reference into the assets to fetch an icon.
  final String? iconRef;

  /// Wheter the control has an icon can use this property
  /// if this property is unset, then will use [foreground].
  final Color? _iconColor;

  /// Wheter the control has an icon can use this property
  /// if this property is unset, then will use [foreground].
  Color get iconColor => _iconColor ?? foreground!;

  /// Defines the control inner text style that will be used.
  ///
  /// If the text style doesn't have defined a [color] then will be overriden with
  /// the property [foreground] from this instance.
  final TextStyle? _textStyle;
  TextStyle? get textStyle {
    return _textStyle?.copyWith(
      color: _textStyle?.color ?? foreground,
    );
  }

  const StandardThemeStruct({
    required this.background,
    required this.foreground,
    this.borderColor,
    this.iconRef,
    TextStyle? textStyle,
    Color? iconColor,
  })  : _textStyle = textStyle,
        _iconColor = iconColor;

  StandardThemeStruct copyWith({
    Color? background,
    Color? foreground,
    Color? borderColor,
    String? iconRef,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    return StandardThemeStruct(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      borderColor: borderColor ?? this.borderColor,
      iconRef: iconRef ?? iconRef,
      iconColor: iconColor ?? _iconColor,
      textStyle: textStyle ?? _textStyle,
    );
  }
}

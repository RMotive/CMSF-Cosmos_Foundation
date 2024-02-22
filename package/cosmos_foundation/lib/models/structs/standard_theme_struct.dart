import 'dart:ui';

/// Defines a class that handles a bundle of properties used by controls standard theming
class StandardThemeStruct {
  /// Defines the control surface color
  final Color background;

  /// Defines the inner text color.
  final Color textColor;

  /// Defines the control border color
  final Color? borderColor;

  /// Defines a reference into the assets to fetch an icon.
  final String? iconRef;

  /// Wheter the control has an icon can use this property
  /// if this property is unset, then will use [textColor].
  final Color? _iconColor;

  /// Wheter the control has an icon can use this property
  /// if this property is unset, then will use [textColor].
  Color get iconColor => _iconColor ?? textColor;

  /// Defines the control inner text style that will be used.
  final TextStyle? textStyle;

  const StandardThemeStruct({
    required this.background,
    required this.textColor,
    this.borderColor,
    this.iconRef,
    this.textStyle,
    Color? iconColor,
  }) : _iconColor = iconColor;
}

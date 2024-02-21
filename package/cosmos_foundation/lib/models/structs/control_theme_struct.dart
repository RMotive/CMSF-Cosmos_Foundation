import 'dart:ui';

/// Specifies a theming struct for controls.
class ControlThemeStruct {
  /// Color for the control background.
  final Color background;

  /// Specifies the color of the text on the control.
  final Color textColor;

  /// Specifies the icon color if there is one, otherwise will use [textColor].
  final Color? iconColor;

  final Color? borderColor;

  const ControlThemeStruct({
    required this.background,
    required this.textColor,
    this.iconColor,
    this.borderColor,
  });
}
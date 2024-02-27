import 'package:flutter/material.dart';

import 'package:cosmos_foundation/models/structs/standard_theme_struct.dart';

/// Specifies a theming struct for state foundation controls.
class StateControlThemeStruct {
  /// The button default state theme to use.
  ///
  /// If there's not another state defined, but the control is in one of the other
  /// states, will use this[mainStruct] as default values.
  final StandardThemeStruct mainStruct;

  /// Defines a theme struct for the control when it is hovered.
  final StandardThemeStruct? _hoverStruct;
  /// Defines a theme struct for the control when it is hovered.
  StandardThemeStruct? get hoverStruct {
    if (_hoverStruct == null) return null;

    Color? background = _hoverStruct?.background;
    Color? foreground = _hoverStruct?.foreground;
    TextStyle? textStyle = _hoverStruct?.textStyle;
    
    return _hoverStruct?.copyWith(
      background: background ?? mainStruct.background,
      foreground: foreground ?? mainStruct.foreground,
      textStyle: textStyle ?? mainStruct.textStyle,
    );
  }

  /// Defines a theme struct for the control when it is selected.
  final StandardThemeStruct? _selectStruct;
  /// Defines a theme struct for the control when it is selected.
  StandardThemeStruct? get selectStruct {
    if (_selectStruct == null) return null;

    Color? background = _selectStruct?.background;
    Color? foreground = _selectStruct?.foreground;
    TextStyle? textStyle = _selectStruct?.textStyle;

    return _selectStruct?.copyWith(
      background: background ?? mainStruct.background,
      foreground: foreground ?? mainStruct.foreground,
      textStyle: textStyle ?? mainStruct.textStyle,
    );
  }
  
  const StateControlThemeStruct({
    required this.mainStruct,
    StandardThemeStruct? hoverStruct,
    StandardThemeStruct? selectStruct,
  })  : _selectStruct = selectStruct,
        _hoverStruct = hoverStruct;
}

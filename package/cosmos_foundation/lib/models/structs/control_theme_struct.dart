import 'package:cosmos_foundation/models/structs/standard_theme_struct.dart';

/// Specifies a theming struct for state foundation controls.
class StateControlThemeStruct {
  /// The button default state theme to use.
  ///
  /// If there's not another state defined, but the control is in one of the other
  /// states, will use this[mainStruct] as default values.
  final StandardThemeStruct mainStruct;

  /// Defines a theme struct for the control when it is hovered.
  final StandardThemeStruct? hoverStruct;

  /// Defines a theme struct for the control when it is selected.
  final StandardThemeStruct? selectStruct;

  const StateControlThemeStruct({
    required this.mainStruct,
    this.hoverStruct,
    this.selectStruct,
  });
}

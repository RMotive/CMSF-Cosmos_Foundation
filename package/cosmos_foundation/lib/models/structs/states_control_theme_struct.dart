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
  StandardThemeStruct? get hoverStruct {
    if (_hoverStruct == null) return null;

    if (_hoverStruct?.background != null) return _hoverStruct;

    return _hoverStruct?.copyWith(
      background: mainStruct.background,
    );
  }

  /// Defines a theme struct for the control when it is selected.
  final StandardThemeStruct? _selectStruct;

  const StateControlThemeStruct({
    required this.mainStruct,
    StandardThemeStruct? hoverStruct,
    StandardThemeStruct? selectStruct,
  })  : _selectStruct = selectStruct,
        _hoverStruct = hoverStruct;
}

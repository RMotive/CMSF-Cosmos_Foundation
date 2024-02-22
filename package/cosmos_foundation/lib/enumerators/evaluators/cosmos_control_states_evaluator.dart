import 'package:cosmos_foundation/enumerators/cosmos_control_states.dart';
import 'package:cosmos_foundation/models/structs/standard_theme_struct.dart';
import 'package:cosmos_foundation/models/structs/states_control_theme_struct.dart';

T evaluatePropertyState<T>(
  CosmosControlStates state, {
  T? onHover,
  T? onSelect,
  required T onIdle,
}) {
  switch (state) {
    case CosmosControlStates.hovered:
      return onHover ?? onIdle;
    case CosmosControlStates.selected:
      return onSelect ?? onIdle;
    default:
      return onIdle;
  }
}

T evaluateBuildPropertyState<T>(
  CosmosControlStates state, {
  T Function()? onHover,
  T Function()? onSelect,
  required T Function() onIdle,
}) {
  switch (state) {
    case CosmosControlStates.hovered:
      return onHover?.call() ?? onIdle();
    case CosmosControlStates.selected:
      return onSelect?.call() ?? onIdle();
    default:
      return onIdle();
  }
}

StandardThemeStruct evaluateThemeState(
  CosmosControlStates state,
  StateControlThemeStruct struct,
) {
  switch (state) {
    case CosmosControlStates.hovered:
      return struct.hoverStruct ?? struct.mainStruct;
    case CosmosControlStates.selected:
      return struct.selectStruct ?? struct.mainStruct;
    default:
      return struct.mainStruct;
  }
}

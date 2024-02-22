import 'package:cosmos_foundation/enumerators/cosmos_control_states.dart';

T evaluateControlState<T>(
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

import 'package:cosmos_foundation/models/structs/clamp_constraints.dart';

double calSlicedThreshold(double current, ClampConstraints constraints) {
  final ClampConstraints cts = constraints;

  // --> Simple validations
  if (current <= cts.minBreak) return cts.minValue;
  if (current >= cts.maxBreak) return cts.maxBreak;

  double breakGap = cts.maxBreak - cts.minBreak;
  double currentVal = current - cts.minBreak;
  double trsPercent = currentVal / breakGap;

  return cts.maxValue * trsPercent;
}

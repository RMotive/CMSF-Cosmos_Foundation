/// Struct to define an advance clamp double calculation properties.
class ClampRatioConstraints {
  /// Defines the min possible value resulted.
  final double minValue;

  /// Defines where the min possible value arise.
  final double minBreak;

  /// Defines the max possible value resulted.
  final double maxValue;

  /// Defines where the max possible value arise.
  final double maxBreak;

  /// Creates a [ClampRatioConstraints] struct instance.
  const ClampRatioConstraints(this.minBreak, this.maxBreak, this.minValue, this.maxValue);

  /// Creates a [ClampRatioConstraints] struct instance with named parameters to describe.
  const ClampRatioConstraints.on({
    required double minValue,
    required double minBreak,
    required double maxValue,
    required double maxBreak,
  }) : this(minBreak, maxBreak, minValue, maxValue);
}

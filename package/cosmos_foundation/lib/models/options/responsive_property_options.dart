import 'package:cosmos_foundation/models/options/responsive_property_breakpoint_options.dart';

/// Options class.
/// This class defines options for a specific use-case.
///
/// Represents three properties values for different screen sizes.
///
/// Used in
///   [Responsive] helper class.
///     [propertyFromDefault] method.
class ResponsivePropertyOptions<T> {
  /// Small devices value.
  final T small;

  /// Medium devices value.
  final T medium;

  /// Large devices value.
  final T large;

  /// Creates a object instance that stores three properties values to be calculated along
  /// devices screen sizes.
  const ResponsivePropertyOptions(this.small, this.medium, this.large);
}

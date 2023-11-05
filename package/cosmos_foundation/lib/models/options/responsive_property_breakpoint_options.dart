/// Options class.
/// This class defines options for custom breakpoints and the
/// value desired at this breakpoint its fired.
///
/// Represents a specific desired breakpoint over the surface responsive calculations
/// should have the value where you want to fire or select the value provided that this
/// breakpoint option represents.
///
/// Used in:
///   [Responsive] helper class.
///     [propertyFromBreakpoints] method.
class ResponsivePropertyBreakpointOptions<T> {
  /// Where the responsive calculator will use this value as de desired one.
  final double breakpoint;

  /// The value that will be used in case the breakpoint matches.
  final T value;

  /// Creates a object intance that stores the expected breakpoint value and the value
  /// that specified by the breakpint.
  const ResponsivePropertyBreakpointOptions(this.breakpoint, this.value);

  @override
  String toString() => 'BP: $breakpoint, V: $value';
}

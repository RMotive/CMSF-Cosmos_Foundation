import 'package:cosmos_foundation/models/options/responsive_property_breakpoint_options.dart';

// --> Helpers

/// Extension class.
/// Creates an extension from a list of specific class object.
///
/// We are creating an extension right here to create a method that will order
/// the current breakpoints list to be used anywhere.
extension BreakpointsList<T> on List<ResponsivePropertyBreakpointOptions<T>> {
  /// Will order the [List] of [ResponsivePropertyBreakpointOptions] in the correct
  /// logical order, from the lowest to the higher, and will discard the
  /// ilogical breakpoints detected.
  ///
  /// Returns the ordered [List] of [ResponsivePropertyBreakpointOptions].
  ///
  /// Note: Know as ilogical breakpoints, all repeated breakpoint value after the first one found will be removed.
  List<ResponsivePropertyBreakpointOptions<T>> sortBreakpoints() {
    List<ResponsivePropertyBreakpointOptions<T>> orderedList = this;
    orderedList.sort((ResponsivePropertyBreakpointOptions<T> a, ResponsivePropertyBreakpointOptions<T> b) => a.breakpoint.compareTo(b.breakpoint));
    int point = 0;
    while (point < (orderedList.length - 1)) {
      final ResponsivePropertyBreakpointOptions<T> currentItem = orderedList[point];
      final ResponsivePropertyBreakpointOptions<T> nextItem = orderedList[point + 1];
      if (!(currentItem.breakpoint == nextItem.breakpoint)) continue;
      orderedList.removeAt(point + 1);
    }

    return orderedList;
  }
}

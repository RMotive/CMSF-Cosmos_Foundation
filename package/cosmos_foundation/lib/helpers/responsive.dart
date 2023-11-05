import 'dart:ui';

import 'package:cosmos_foundation/models/options/responsive_property_breakpoint_options.dart';
import 'package:cosmos_foundation/models/options/responsive_property_options.dart';

/// Singleton Helper.
/// This helper provides several responsiveness functionallities.
///
/// Specialized on surface calculations to conditionally decide between several properties or another
/// kind of values based on its base default breakpoints or custom provided breakpoints.
///
/// Default considerations.
/// Breakpoints:
///   For small devices: 0 >= breakpoint < 600
///   For medium devices 600 >= breakpoint < 1200
///   For large devices  1200 => breakpoint
class Responsive {
  static Responsive? _instance;
  // Avoid self instance
  Responsive._();

  /// Helper intance.
  static Responsive get instance => _instance ??= Responsive._();

  /// Breakpoint value for small devices.
  final double _bpSmall = 600;

  /// Breakpoint value for medium devices.
  final double _bpMedium = 1200;

  /// Calculates the resolved value based on the default breakpoints values and the provided
  /// values provided in [options].
  ///
  /// Default considerations.
  /// Breakpoints:
  ///   For small devices: 0 >= breakpoint < 600
  ///   For medium devices 600 >= breakpoint < 1200
  ///   For large devices  1200 => breakpoint
  T propertyFromDefault<T>(ResponsivePropertyOptions<T> options) {
    final double screenSurface = PlatformDispatcher.instance.displays.first.size.width;
    if (screenSurface < _bpSmall) return options.small;
    if (screenSurface < _bpMedium) return options.medium;
    return options.large;
  }

  /// Calculates the resolved value based on a custom breakpoints list with the values provided
  /// in [breakpints].
  ///
  /// The breakpoints are calculated from the lowest breakpoint value to the highest one.
  T propertyFromBreakpoints<T>(List<ResponsivePropertyBreakpointOptions<T>> breakpoints) {
    return '' as T;
  }
}

/// Extension class.
///
/// Adds extended and custom methods for String data type.
extension StringExtension on String {
  /// Calculates and returns if the current [String] starts with uppercase.
  bool get startUppercase {
    final String startLetter = substring(0, 1);
    return startLetter.toUpperCase() == startLetter;
  }

  /// Calculates and returns the [String] starting with uppercase.
  String toStartUpperCase() {
    if (startUppercase) return this;
    final String startLetter = substring(0, 1);
    return '${startLetter.toUpperCase()}${substring(1, length)}';
  }
}

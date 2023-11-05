import 'dart:math';

import 'package:cosmos_foundation/extensions/string_extension.dart';
import 'package:flutter/material.dart';

/// Helper class.
///
/// This class provides several logging methods to write standarized and colorful
/// console messages about actions or processes.
///
/// Considerations:
///   Default colors:
///     Success:
class Advisor {
  /// Stores an advisor tag to separate advisors along the application lifecycle
  final String _advisorTag;

  /// Stores and defines if all messages wroten with this instnace will be tuned into
  /// messages that start with uppercase.
  final bool startMessageUpper;

  /// Color for all the messages tag
  ///
  /// This color will be visible in the tags for all messages.
  final Color tagColor;

  /// Color for success messages.
  final Color successColor;

  /// Color for waning messages;
  final Color warningColor;

  /// Gets the advisor tag in a to-display format.
  String get _tag => _advisorTag.toUpperCase().substring(0, min(30, _advisorTag.length));

  /// Creates a new one Advisor helper object.
  ///
  /// Stores a specific Advisor tag to get a better trace of who and where the
  /// message was fired.
  const Advisor(
    String advisorTag, {
    this.startMessageUpper = true,
    this.tagColor = Colors.orangeAccent,
    this.successColor = Colors.tealAccent,
    this.warningColor = Colors.amberAccent,
  }) : _advisorTag = advisorTag;

  /// Writes a sucess advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void adviseSuccess(String message, {Map<String, dynamic>? info, bool? startWithUpper}) => _advise(message, successColor, info: info, startWithUpper: startWithUpper);

  /// Writes a warning advise in console.
  void adviseWarning(String message, {Map<String, dynamic>? info, bool? startWithUpper}) => _advise(message, warningColor, info: info, startWithUpper: startWithUpper);

  /// Main advisor encapsuled method, each method that represents a new advise action depends on call this one,
  /// this method takes the relevant data to write and advise colorized console messages based on the provided inputs.
  ///
  /// DEV NOTE: Always when you create a new one method in this helper abount write new messages, keep the name format and
  /// the call to this main handler method.
  void _advise(String message, Color color, {Map<String, dynamic>? info, bool? startWithUpper}) {
    String formatted = _buildBasicFormattedMessage(message, color, startWithUpper: startMessageUpper);
    debugPrint(formatted);
    if (info == null) return;
    debugPrint(_colorizeStringAndReset(color, '\tinfo:'));
    for (MapEntry<String, dynamic> infoEntry in info.entries) {
      final String textLine = '\t[${infoEntry.key}]: ${infoEntry.value}';
      debugPrint(_colorizeStringAndReset(color, textLine));
    }
  }

  /// Formats and handles the standarizationg of the displayed message.
  ///
  /// Here the message is case-formatted and colorized.
  String _buildBasicFormattedMessage(String message, Color color, {bool? startWithUpper}) {
    String standarized = message;
    if ((startMessageUpper && (startWithUpper != false)) || (startWithUpper == true)) {
      standarized = standarized.toStartUpperCase();
    }

    final String colorizedTag = _colorizeStringAndReset(tagColor, '[$_tag]');
    final String colorizedHeader = _colorizeStringAndReset(color, standarized);
    return '$colorizedTag $colorizedHeader';
  }

  /// Wraps a string in a colorized ansii scape to be understandable by the debug console.
  String _colorizeStringAndReset(Color color, String msg) => '\u001b[38;2;${color.red};${color.green};${color.blue}m$msg\u001b[0m';
}

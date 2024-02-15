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
  /// Indicates the key to display on timemark property at advise messages.
  static const String _kAdviseTimemarkKeyDisplay = "Timemark";

  /// Indicates the key to display on extra details property at advise messages.
  static const String _kAdviseDetailsKeyDisplay = "Details";


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

  /// Color for waning messages.
  final Color warningColor;

  /// Color for advise messages.
  final Color messageColor;

  /// Color for advise exceptions.
  final Color exceptionColor;

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
    this.messageColor = Colors.lightBlue,
    this.exceptionColor = Colors.red,
  }) : _advisorTag = advisorTag;

  /// Writes a sucess advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void adviseSuccess(
    String message, {
    Map<String, dynamic>? info,
    bool? startWithUpper,
  }) =>
      _advise(message, successColor, info: info, startWithUpper: startWithUpper);

  /// Writes a warning advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void adviseWarning(
    String message, {
    Map<String, dynamic>? info,
    bool? startWithUpper,
  }) =>
      _advise(message, warningColor, info: info, startWithUpper: startWithUpper);

  /// Writes an exception advise in console.
  ///
  /// [subject] message header that will be displayed.
  ///
  /// [x] exception catched to advise.
  ///
  /// [t] tracer for exception source.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void adviseException(
    String subject,
    Exception x,
    StackTrace t, {
    Map<String, dynamic>? info,
    bool? startWithUpper,
  }) =>
      _advise(subject, exceptionColor,
          info: <String, dynamic>{
            "message": x,
            "trace": t.toString().replaceAll('\t', '').replaceAll('\n', '').replaceAll('     ', ''),
          }..addEntries(
              info?.entries ?? <MapEntry<String, dynamic>>[],
            ),
          startWithUpper: startWithUpper);

  /// Writes a message advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void adviseMessage(String message, {Map<String, dynamic>? info, bool? startWithUpper}) => _advise(message, messageColor, info: info, startWithUpper: startWithUpper);

  /// Main advisor encapsuled method, each method that represents a new advise action depends on call this one,
  /// this method takes the relevant data to write and advise colorized console messages based on the provided inputs.
  ///
  /// DEV NOTE: Always when you create a new one method in this helper abount write new messages, keep the name format and
  /// the call to this main handler method.
  void _advise(String message, Color color, {Map<String, dynamic>? info, bool? startWithUpper}) {
    final String adviseHeader = _buildBasicFormattedMessage(message, color, includeTag: true);
    debugPrint(adviseHeader);
    final String timemark = DateTime.now().toIso8601String();
    final String adviseTimemark = _buildBasicFormattedMessage('$_kAdviseTimemarkKeyDisplay: $timemark', color);
    debugPrint(adviseTimemark);
    if (info == null) return;
    final String adviseDetailsDisplay = _buildBasicFormattedMessage('$_kAdviseDetailsKeyDisplay:', color);
    debugPrint(adviseDetailsDisplay);
    objectPrinter(1, '\t', color, info);
  }

  /// Formats and handles the standarizationg of the displayed message.
  ///
  /// Here the message is case-formatted and colorized.
  String _buildBasicFormattedMessage(String message, Color color, {bool? startWithUpper, bool includeTag = false}) {
    String standarized = message;
    if ((startMessageUpper && (startWithUpper != false)) || (startWithUpper == true)) {
      standarized = standarized.toStartUpperCase();
    }

    final String colorizedTag = _colorizeStringAndReset(tagColor, '[(*)$_tag]');
    final String colorizedHeader = _colorizeStringAndReset(color, standarized);
    String display = colorizedHeader;
    if (includeTag) display = '$colorizedTag $colorizedHeader';
    return display;
  }

  void objectPrinter(int depthLevel, String depthIndent, Color color, Map<String, dynamic> details) {
    for (MapEntry<String, dynamic> detail in details.entries) {
      final String key = detail.key;
      final dynamic content = detail.value;
      if (content is! Map) {
        final String standardFormat = '$depthIndent[$key]: $content';
        final String standardDisplayAdvise = _buildBasicFormattedMessage(standardFormat, color);
        debugPrint(standardDisplayAdvise);
        continue;
      }

      final String newObjectFormat = '$depthIndent[$key]:';
      final String newObjectKeyDisplay = _buildBasicFormattedMessage(newObjectFormat, color);
      debugPrint(newObjectKeyDisplay);
      final Map<String, dynamic> castedContentToObject = (content as Map<String, dynamic>);
      objectPrinter(depthLevel + 1, '$depthIndent\t', color, castedContentToObject);
    }
  }

  /// Wraps a string in a colorized ansii scape to be understandable by the debug console.
  String _colorizeStringAndReset(Color color, String msg) => '\u001b[38;2;${color.red};${color.green};${color.blue}m$msg\u001b[0m';
}

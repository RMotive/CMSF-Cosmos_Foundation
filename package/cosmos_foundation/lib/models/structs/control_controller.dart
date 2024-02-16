import 'package:cosmos_foundation/helpers/advisor.dart';
import 'package:cosmos_foundation/helpers/focuser.dart';
import 'package:flutter/widgets.dart';

/// Structural class to store and handle a structural behavior.
///
/// This class specifies a bundle of tools to handle and manahe controls, like
/// text editing controller, foucs node, etc...
class ControlController {
  /// Stores a way to identify the current object context with a controller.
  final String name;

  /// The current control text controller stored.
  ///
  /// Just for Input controls.
  final TextEditingController? textController;

  /// The current control focus controller stored.
  final FocusNode? focusController;

  /// Creates a control controller struct with specific configuration given.
  const ControlController(
    this.name, {
    this.textController,
    this.focusController,
  });

  /// Creates a control controller struct auto generating all internal controllers.
  factory ControlController.genAll(String name) {
    return ControlController(
      name,
      focusController: FocusNode(),
      textController: TextEditingController(),
    );
  }

  /// Request for the control text
  /// If the current control doesn`t have a text editing controller, will be returned [''] empty string.
  String get text {
    if (textController != null) return (textController?.text as String);
    Advisor('CONTROL-[($name)]').adviseWarning('Current controller context doesn\'t have a text editing controller');
    return '';
  }

  /// Request to get the focus on the current control context.
  void focus() {
    if (focusController != null) return Focuser.focus(focusController as FocusNode);
    Advisor('CONTROL-[($name)]').adviseWarning('Current controller context doesn\'t have a focus controller');
    return;
  }
}

import 'package:flutter/widgets.dart';

class Focuser {
  static void focus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      node.requestFocus();
    });
  }

  static void unfocus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      node.unfocus();
    });
  }
}

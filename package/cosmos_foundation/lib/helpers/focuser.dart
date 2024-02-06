import 'package:flutter/widgets.dart';

class Focuser {
  void focus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      node.requestFocus();
    });
  }

  void unfocus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      node.unfocus();
    });
  }
}

import 'package:flutter/material.dart';

class Advisor {
  static Advisor? _instance;
  // Avoid self instance
  Advisor._();
  static Advisor get instance => _instance ??= Advisor._();

  void adviseSuccess(String message) {
    debugPrint('[Cosmos-Foundation] \x1B[${_DefaultAdvisorColors.successColor.value}m\t$message\x1B[0m');
  }
}

class _DefaultAdvisorColors {
  static const Color successColor = Colors.green;
}

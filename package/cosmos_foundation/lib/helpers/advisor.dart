import 'package:flutter/material.dart';

class Advisor {
  static Advisor? _instance;
  // Avoid self instance
  Advisor._();
  static Advisor get instance => _instance ??= Advisor._();

  void adviseSuccess(String message) {
    debugPrint('\x1B[32m[Cosmos-Foundation] $message\x1B[0m');
  }
}

class _DefaultAdvisorColors {
  static const Color successColor = Colors.green;
}

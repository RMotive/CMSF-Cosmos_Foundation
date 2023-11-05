import 'package:cosmos_foundation/helpers/advisor.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  Advisor adv = const Advisor('example-app');

  adv.adviseSuccess(
    'this is a sucess message',
    info: {'example': 'maybe should write this'},
  );
  adv.adviseWarning(
    'this is a warning message',
    info: {'example': 'maybe should write this'},
  );
  runApp(
    const MaterialApp(),
  );
}

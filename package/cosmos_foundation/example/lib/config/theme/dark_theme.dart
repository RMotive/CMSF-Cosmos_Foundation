import 'package:example/config/theme/theme_base.dart';
import 'package:flutter/material.dart';

class DarkTheme extends ThemeBase {
  const DarkTheme()
      : super(
          'static-dart',
          primaryColor: Colors.orange,
          secondaryColor: Colors.blueGrey,
        );
}

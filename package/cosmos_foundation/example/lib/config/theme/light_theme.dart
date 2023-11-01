import 'package:example/config/theme/theme_base.dart';
import 'package:flutter/material.dart';

class LightTheme extends ThemeBase {
  const LightTheme()
      : super(
          'static-light',
          primaryColor: Colors.yellow,
          secondaryColor: Colors.green,
        );
}

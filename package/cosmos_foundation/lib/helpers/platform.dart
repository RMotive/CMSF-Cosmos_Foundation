import 'package:cosmos_foundation/helpers/conditions.dart';
import 'package:flutter/foundation.dart';

// --> Helpers
final Conditions _cdt = Conditions.i;

class Platform {
  static Platform? _instance;
  // Avoid self instance
  Platform._();
  static Platform get i => _instance ??= Platform._();

  bool get isWeb => kIsWeb;
  bool get isMobile => _cdt.isSomeone(defaultTargetPlatform, [TargetPlatform.android, TargetPlatform.fuchsia, TargetPlatform.iOS]);
  bool get isDesktop => _cdt.isSomeone(defaultTargetPlatform, [TargetPlatform.linux, TargetPlatform.macOS, TargetPlatform.windows]);
  PlatformContexts get context => isWeb
      ? PlatformContexts.web
      : isMobile
          ? PlatformContexts.mobile
          : PlatformContexts.desktop;
}

enum PlatformContexts {
  web,
  mobile,
  desktop,
}

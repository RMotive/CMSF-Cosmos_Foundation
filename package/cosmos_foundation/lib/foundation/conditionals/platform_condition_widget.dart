import 'package:cosmos_foundation/helpers/platform.dart';
import 'package:flutter/material.dart';

// --> Helpers
final Platform _ptf = Platform.i;

class PlatformConditionWidget<T extends Widget> extends StatelessWidget {
  final T? desktopValue;
  final T? mobileValue;
  final T? webValue;

  const PlatformConditionWidget({
    super.key,
    this.desktopValue,
    this.mobileValue,
    this.webValue,
  });

  @override
  Widget build(BuildContext context) {
    if (_ptf.isWeb && webValue == null || _ptf.isMobile && mobileValue == null || _ptf.isDesktop && desktopValue == null) {
      return ErrorWidget("You're on ${_ptf.context.name} and the value provided is null");
    }

    if (_ptf.isWeb) return webValue as Widget;
    if (_ptf.isDesktop) return desktopValue as Widget;
    return mobileValue as Widget;
  }
}

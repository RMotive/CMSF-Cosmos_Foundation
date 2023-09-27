import 'package:cosmos_foundation/extensions/int_extension.dart';
import 'package:cosmos_foundation/widgets/hooks/future_widget.dart';
import 'package:cosmos_foundation/widgets/simplifiers/colored_sizedbox.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final ValueListenable<ThemeMode> themeHandler = ValueNotifier<ThemeMode>(ThemeMode.dark);
final GlobalKey<NavigatorState> navigatorHandler = GlobalKey();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeHandler,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: value,
          navigatorKey: navigatorHandler,
          home: const _Showcase(),
        );
      },
    );
  }
}

class _Showcase extends StatelessWidget {
  const _Showcase();

  Future<bool> example() async {
    await Future.delayed(2.seconds);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white70,
        child: Center(
          child: FutureWidget(
            future: example(),
            successBuilder: (_, ___, __) {
              return const ColoredSizedbox(
                backgroundColor: Colors.red,
                boxSize: Size(100, 100),
              );
            },
          ),
        ),
      ),
    );
  }
}

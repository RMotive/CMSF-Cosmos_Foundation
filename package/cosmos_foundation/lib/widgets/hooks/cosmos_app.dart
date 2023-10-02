import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:cosmos_foundation/helpers/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;

class CosmosApp<TThemeBase extends CosmosThemeBase> extends StatefulWidget {
  final TThemeBase? defaultTheme;
  final List<TThemeBase>? themes;
  final Widget Function(BuildContext context)? homeBuilder;

  const CosmosApp({
    super.key,
    this.defaultTheme,
    this.themes,
    this.homeBuilder,
  });

  @override
  State<CosmosApp<TThemeBase>> createState() => _CosmosAppState<TThemeBase>();
}

class _CosmosAppState<TThemeBase extends CosmosThemeBase> extends State<CosmosApp<TThemeBase>> {
  late final ValueListenable listener;
  
  @override
  void initState() {
    super.initState();
    initTheme(widget.defaultTheme, widget.themes);
    listener = listenTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listener,
      builder: (context, value, child) {
        return MaterialApp(
          home: widget.homeBuilder?.call(context),
        );
      },
    );
  }
}

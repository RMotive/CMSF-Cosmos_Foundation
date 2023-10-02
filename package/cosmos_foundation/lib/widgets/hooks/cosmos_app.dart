import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:cosmos_foundation/helpers/theme.dart';
import 'package:flutter/material.dart' hide Theme;

class CosmosApp<TThemeBase extends CosmosThemeBase, TTheme extends TThemeBase> extends StatefulWidget {
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
  State<CosmosApp<TThemeBase, TTheme>> createState() => _CosmosAppState<TThemeBase, TTheme>();
}

class _CosmosAppState<TThemeBase extends CosmosThemeBase, TTheme extends TThemeBase> extends State<CosmosApp<TThemeBase, TTheme>> {
  @override
  void initState() {
    super.initState();
    initTheme(widget.defaultTheme, widget.themes);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenTheme(),
      builder: (context, value, child) {
        return MaterialApp(
          home: widget.homeBuilder?.call(context),
        );
      },
    );
  }
}

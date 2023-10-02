import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:cosmos_foundation/helpers/theme.dart';
import 'package:flutter/material.dart' hide Theme;

import 'package:flutter/material.dart';

class CosmosApp<TThemeBase extends CosmosThemeBase> extends StatefulWidget {
  final TThemeBase? defaultTheme;
  final Widget? homeWidget;
  final Widget Function(BuildContext context, TThemeBase theme)? homeBuilder;
  final Widget Function(BuildContext, Widget?)? generalBuilder;
  final RouterDelegate<Object>? routerDelegate;
  final RouterConfig<Object>? routerConfig;
  

  const CosmosApp({
    super.key,
    this.defaultTheme,
    this.homeBuilder,
    this.homeWidget,
    this.generalBuilder,
    this.routerConfig,
    this.routerDelegate,
  }) : assert(((homeWidget != null) != (homeBuilder != null)) || (homeWidget == null && homeBuilder == null), "The home widget and builder cannot be at the same time, must be just one or no one");

  const CosmosApp.router({
    super.key,
    this.defaultTheme,
    this.generalBuilder,
    this.routerConfig,
    this.routerDelegate,
  })  : assert(routerConfig != null || routerDelegate != null, "Router config or Router delegate must be defined to use a router based Cosmos App"),
        homeBuilder = null,
        homeWidget = null;


  @override
  State<CosmosApp> createState() => _CosmosAppState();
}

class _CosmosAppState extends State<CosmosApp> {
  late final Widget? byHome;
  bool get _usesRouter => widget.routerDelegate != null || widget.routerConfig != null;


  @override
  void initState() {
    super.initState();
    initTheme(widget.defaultTheme);
    if (widget.homeWidget != null) byHome = widget.homeWidget;
    if (widget.homeBuilder != null) byHome = widget.homeBuilder?.call(context, getTheme());
  }

  @override
  Widget build(BuildContext context) {
    if (_usesRouter) return _buildFromRouter();
    return _build();
  }

  Widget _build() {
    return MaterialApp(
      home: byHome,
      builder: widget.generalBuilder,
    );
  }

  Widget _buildFromRouter() {
    return MaterialApp.router(
      builder: widget.generalBuilder,
      routerConfig: widget.routerConfig,
      routerDelegate: widget.routerDelegate,
    );
  }
}

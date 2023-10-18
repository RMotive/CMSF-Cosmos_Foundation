import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:cosmos_foundation/helpers/theme.dart';
import 'package:flutter/material.dart' hide Theme;

import 'package:flutter/material.dart';

class CosmosApp<TThemeBase extends CosmosThemeBase> extends StatefulWidget {
  final TThemeBase? defaultTheme;
  final Widget? homeWidget;
  final Widget Function(BuildContext context)? homeBuilder;
  final Widget Function(BuildContext context, Widget? home)? generalBuilder;
  final RouterDelegate<Object>? routerDelegate;
  final RouterConfig<Object>? routerConfig;
  final bool listenFrameSize;
  

  const CosmosApp({
    super.key,
    this.defaultTheme,
    this.homeBuilder,
    this.homeWidget,
    this.generalBuilder,
    this.routerConfig,
    this.routerDelegate,
    this.listenFrameSize = false,
  }) : assert(((homeWidget != null) != (homeBuilder != null)) || (homeWidget == null && homeBuilder == null), "The home widget and builder cannot be at the same time, must be just one or no one");

  const CosmosApp.router({
    super.key,
    this.defaultTheme,
    this.generalBuilder,
    this.routerConfig,
    this.routerDelegate,
    this.listenFrameSize = false,
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
    if (widget.homeBuilder != null) byHome = widget.homeBuilder?.call(context);
  }

  @override
  void didUpdateWidget(covariant CosmosApp<CosmosThemeBase> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget wgt = _usesRouter ? _buildFromRouter() : _build();
    if (!widget.listenFrameSize) return wgt;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          Size frameSize = constraints.smallest;

          return Stack(
            children: <Widget>[
              wgt,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(frameSize.toString()),
                ),
              ),
            ],
          );
        },
      ),
    );
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

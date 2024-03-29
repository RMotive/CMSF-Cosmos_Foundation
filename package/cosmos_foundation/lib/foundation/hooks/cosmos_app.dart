
import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:cosmos_foundation/helpers/advisor.dart';
import 'package:cosmos_foundation/helpers/theme.dart';
import 'package:flutter/material.dart' hide Theme;

import 'package:flutter/material.dart';

class CosmosApp<TThemeBase extends CosmosThemeBase> extends StatefulWidget {
  final TThemeBase? defaultTheme;
  final List<TThemeBase> themes;
  final Widget? homeWidget;
  final Widget Function(BuildContext context)? homeBuilder;
  final Widget Function(BuildContext context, Widget? home)? generalBuilder;
  final RouterDelegate<Object>? routerDelegate;
  final RouterConfig<Object>? routerConfig;
  final bool listenFrameSize;
  final bool useLegacyDebugBanner;

  const CosmosApp({
    super.key,
    this.defaultTheme,
    this.homeBuilder,
    this.homeWidget,
    this.generalBuilder,
    this.routerConfig,
    this.routerDelegate,
    this.themes = const <Never>[],
    this.listenFrameSize = false,
    this.useLegacyDebugBanner = false,
  }) : assert(((homeWidget != null) != (homeBuilder != null)) || (homeWidget == null && homeBuilder == null), "The home widget and builder cannot be at the same time, must be just one or no one");

  const CosmosApp.router({
    super.key,
    this.defaultTheme,
    this.generalBuilder,
    this.routerConfig,
    this.routerDelegate,
    this.themes = const <Never>[],
    this.listenFrameSize = false,
    this.useLegacyDebugBanner = false,
  })  : assert(routerConfig != null || routerDelegate != null, "Router config or Router delegate must be defined to use a router based Cosmos App"),
        homeBuilder = null,
        homeWidget = null;


  @override
  State<CosmosApp<CosmosThemeBase>> createState() => _CosmosAppState();
}

class _CosmosAppState extends State<CosmosApp<CosmosThemeBase>> {
  late final Widget? byHome;
  bool get _usesRouter => widget.routerDelegate != null || widget.routerConfig != null;

  late ValueNotifier<CosmosThemeBase> listener;

  @override
  void initState() {
    super.initState();
    initTheme(widget.defaultTheme, widget.themes);
    listener = listenTheme;
    if (widget.homeWidget != null) byHome = widget.homeWidget;
    if (widget.homeBuilder != null) byHome = widget.homeBuilder?.call(context);

    const Advisor('COSMOS').adviseMessage('Starting engines⚙️⚙️⚙️');
  }

  @override
  void didUpdateWidget(covariant CosmosApp<CosmosThemeBase> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Widget buildApp() {
    return _usesRouter ? _buildFromRouter() : _build();
  }

  @override
  Widget build(BuildContext context) => buildApp();

  Widget _build() {
    return MaterialApp(
      home: byHome,
      builder: frameListener,
      restorationScopeId: 'scope-main',
      debugShowCheckedModeBanner: widget.useLegacyDebugBanner,
    );
  }

  Widget _buildFromRouter() {
    return MaterialApp.router(
      builder: frameListener,
      routerConfig: widget.routerConfig,
      routerDelegate: widget.routerDelegate,
      restorationScopeId: 'scope-main-router',
      debugShowCheckedModeBanner: widget.useLegacyDebugBanner,
    );
  }

  

  Widget frameListener(BuildContext ctx, Widget? child) {
    if (!widget.listenFrameSize) {
      return widget.generalBuilder!(context, child);
    }

    return ValueListenableBuilder<CosmosThemeBase>(
      valueListenable: listener,
      builder: (BuildContext context, _, __) {
        return Stack(
          textDirection: TextDirection.ltr,
          children: <Widget>[
            widget.generalBuilder!(context, child),
            const Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: _FrameListener(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FrameListener extends StatelessWidget {
  const _FrameListener();

  @override
  Widget build(BuildContext context) {
    final Size frameSize = MediaQuery.sizeOf(context);
    final CosmosThemeBase theme = getTheme();

    return Text(
      frameSize.toString(),
      style: TextStyle(
        fontSize: 16,
        backgroundColor: Colors.transparent,
        decoration: TextDecoration.none,
        color: theme.frameListenerColor,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

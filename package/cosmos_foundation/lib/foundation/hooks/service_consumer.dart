import 'package:cosmos_foundation/extensions/int_extension.dart';
import 'package:flutter/material.dart';

class ServiceConsumer<T> extends StatelessWidget {
  final Future<T> service;
  final Duration? delay;
  final bool emptyAsError;
  final Widget Function(BuildContext ctx)? loadingBuilder;
  final Widget Function(BuildContext ctx, Object? error, T? data)? errorBuilder;
  final Widget Function(BuildContext ctx, T data) successBuilder;

  const ServiceConsumer({
    super.key,
    this.loadingBuilder,
    this.errorBuilder,
    this.delay,
    this.emptyAsError = false,
    required this.service,
    required this.successBuilder,
  });

  Future<T> futureWrapper() async {
    if (delay != null) await Future<void>.delayed(delay as Duration);
    return service;
  }

  Widget builderWrapper(BuildContext ctx, AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      if (loadingBuilder == null) return const _DefaultLoadingView();
      return loadingBuilder!(ctx);
    }
    if (snapshot.hasError || (emptyAsError && snapshot.data == null)) {
      if (errorBuilder == null) return const _DefaultErrorView();
      return errorBuilder!(ctx, snapshot.error, snapshot.data);
    }

    T data = snapshot.data as T;
    return successBuilder(ctx, data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: futureWrapper(),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        return AnimatedSwitcher(
          duration: 600.miliseconds,
          switchInCurve: Curves.decelerate,
          child: builderWrapper(context, snapshot),
        );
      },
    );
  }
}

class _DefaultLoadingView extends StatelessWidget {
  const _DefaultLoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          color: Theme.of(context).indicatorColor,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            "Recovering data...",
            style: Theme.of(context).textTheme.labelLarge?.apply(
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
      ],
    );
  }
}

class _DefaultErrorView extends StatelessWidget {
  const _DefaultErrorView();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error,
          size: theme.primaryIconTheme.size,
          color: theme.colorScheme.error,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Error cacthed",
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.error,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

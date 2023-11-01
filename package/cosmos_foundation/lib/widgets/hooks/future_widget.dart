import 'package:cosmos_foundation/extensions/int_extension.dart';
import 'package:cosmos_foundation/widgets/hooks/themed_widget.dart';
import 'package:flutter/material.dart';

class FutureWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Duration? delay;
  final bool emptyAsError;
  final Widget Function(BuildContext ctx, BoxConstraints boxSurface)? loadingBuilder;
  final Widget Function(
    BuildContext ctx,
    BoxConstraints boxSurface,
    Object? error,
    T? data,
  )? errorBuilder;
  final Widget Function(BuildContext ctx, BoxConstraints boxSurface, T data) successBuilder;

  const FutureWidget({
    super.key,
    this.loadingBuilder,
    this.errorBuilder,
    this.delay,
    this.emptyAsError = false,
    required this.future,
    required this.successBuilder,
  });

  Future<T> futureWrapper() async {
    if (delay != null) await Future.delayed(delay as Duration);
    return future;
  }

  Widget builderWrapper(BuildContext ctx, BoxConstraints boxSurface, AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      if (loadingBuilder == null) return const _DefaultLoadingView();
      return loadingBuilder!(ctx, boxSurface);
    }
    if (snapshot.hasError || (emptyAsError && snapshot.data == null)) {
      if (errorBuilder == null) return const _DefaultErrorView();
      return errorBuilder!(ctx, boxSurface, snapshot.error, snapshot.data);
    }

    T data = snapshot.data as T;
    return successBuilder(ctx, boxSurface, data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureWrapper(),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          return AnimatedSwitcher(
            duration: 2.seconds,
            switchInCurve: Curves.decelerate,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints boxConstraints) {
                return builderWrapper(context, boxConstraints, snapshot);
              },
            ),
          );
        }
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
            "Reocering data...",
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
    return ThemedWidget(
      builder: (BuildContext context, ThemeData theme) {
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
      },
    );
  }
}

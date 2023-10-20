import 'package:cosmos_foundation/extensions/int_extension.dart';
import 'package:cosmos_foundation/widgets/hooks/themed_widget.dart';
import 'package:flutter/material.dart';

class FutureWidget<T> extends StatefulWidget {
  final Future<T> future;
  final Duration? delay;
  final bool emptyAsError;
  final bool enableRecall;
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
    this.enableRecall = false,
    required this.future,
    required this.successBuilder,
  });

  @override
  State<FutureWidget<T>> createState() => _FutureWidgetState<T>();
}

class _FutureWidgetState<T> extends State<FutureWidget<T>> {
  // --> Init resources
  Widget? storedResult;

  Future<T> futureWrapper() async {
    if (widget.delay != null) await Future.delayed(widget.delay as Duration);
    return widget.future;
  }

  Widget builderWrapper(BuildContext ctx, BoxConstraints boxSurface, AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      if (widget.loadingBuilder == null) return const _DefaultLoadingView();
      return widget.loadingBuilder!(ctx, boxSurface);
    }
    if (snapshot.hasError || (widget.emptyAsError && snapshot.data == null)) {
      if (widget.errorBuilder == null) return const _DefaultErrorView();
      return widget.errorBuilder!(ctx, boxSurface, snapshot.error, snapshot.data);
    }

    T data = snapshot.data as T;
    return widget.successBuilder(ctx, boxSurface, data);
  }

  @override
  Widget build(BuildContext context) {
    if (storedResult != null && !widget.enableRecall) return storedResult!;
    return FutureBuilder(
        future: futureWrapper(),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          return AnimatedSwitcher(
            duration: 2.seconds,
            switchInCurve: Curves.decelerate,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                storedResult = builderWrapper(context, constraints, snapshot);
                return storedResult!;
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
      builder: (context, theme) {
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

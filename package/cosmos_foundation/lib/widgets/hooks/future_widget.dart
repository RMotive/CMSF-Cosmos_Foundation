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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        return FutureBuilder(
          future: futureWrapper(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              if (loadingBuilder == null) return const _DefaultLoadingView();
              return loadingBuilder!(context, boxConstraints);
            }
            if (snapshot.hasError || (emptyAsError && snapshot.data == null)) {
              if (errorBuilder == null) return const _DefaultErrorView();
              return errorBuilder!(context, boxConstraints, snapshot.error, snapshot.data);
            }

            T data = snapshot.data as T;
            return successBuilder(context, boxConstraints, data);
          },
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
    return Container();
  }
}

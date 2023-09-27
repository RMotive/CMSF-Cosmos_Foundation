part of '../app_wrapper.dart';

class _MobileWrapper extends StatelessWidget {
  final ThemeData theme;
  final Widget child;

  const _MobileWrapper({
    required this.child,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(
          builder: (context) {
            return Scaffold(
              backgroundColor: theme.colorScheme.background,
              endDrawer: const _MobileAppDrawer(),
              appBar: _mobileAppBar,
              body: child,
            );
          },
        )
      ],
    );
  }
}

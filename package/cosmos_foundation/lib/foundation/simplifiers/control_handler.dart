import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ControlHandler extends StatelessWidget {
  final void Function(bool)? onHover;
  final VoidCallback? onClick;
  final MouseCursor cursor;
  final Widget? child;
  const ControlHandler({
    super.key,
    this.cursor = MouseCursor.defer,
    this.onClick,
    this.onHover,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: cursor,
      onEnter: onHover != null
          ? (PointerEnterEvent event) {
              onHover?.call(true);
            }
          : null,
      onExit: onHover != null
          ? (PointerExitEvent event) {
              onHover?.call(false);
            }
          : null,
      child: GestureDetector(
        onTap: onClick,
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

abstract class CosmosPage extends StatelessWidget {
  const CosmosPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constrains.maxWidth,
              minHeight: constrains.maxHeight,
            ),
            child: compose(context, screenSize),
          ),
        );
      },
    );
  }

  Widget compose(BuildContext ctx, Size window);
}

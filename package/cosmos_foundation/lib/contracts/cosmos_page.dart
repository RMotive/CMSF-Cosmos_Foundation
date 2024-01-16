import 'package:flutter/material.dart';

abstract class CosmosPage extends StatelessWidget {
  const CosmosPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screenSize.width,
          minHeight: screenSize.height,
        ),
        child: compose(context, screenSize),
      ),
    );
  }

  Widget compose(BuildContext ctx, Size window);
}

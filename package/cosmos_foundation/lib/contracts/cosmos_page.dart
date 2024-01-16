import 'package:flutter/material.dart';

abstract class CosmosPage extends StatelessWidget {
  const CosmosPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      primary: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screenSize.width,
          minHeight: screenSize.height,
        ),
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: compose(context),
        ),
      ),
    );
  }

  Widget compose(BuildContext ctx);
}

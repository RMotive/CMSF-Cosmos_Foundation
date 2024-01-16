import 'package:flutter/material.dart';

abstract class CosmosPage extends StatelessWidget {
  const CosmosPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: screenSize.width,
        minHeight: screenSize.height,
      ),
      child: SingleChildScrollView(
        child: compose(),
      ),
    );
  }

  Widget compose();
}

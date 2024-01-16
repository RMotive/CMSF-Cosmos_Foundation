import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/foundation/simplifiers/colored_sizedbox.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: ExamplePage(),
    ),
  );
}

class ExamplePage extends CosmosPage {
  const ExamplePage({super.key});

  @override
  Widget compose(BuildContext ctx, Size window) {
    return SizedBox.fromSize(
      size: window,
      child: Center(
        child: Row(
          children: [
            const SizedBox(
              height: 200,
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/helpers/router.dart' as hr;
import 'package:example/config/routes/routes.dart';
import 'package:example/screens/init_page.dart';
import 'package:flutter/material.dart';

// --> Helpers
final hr.Router _router = hr.Router.i;

class BluegreyPage extends CosmosPage {
  const BluegreyPage({super.key})
      : super(
          yellowRoute,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: ElevatedButton(
            onPressed: () => _router.routeTo(
                  const InitPage(),
                ),
            child: const Text('Back to init page')),
      ),
    );
  }
}

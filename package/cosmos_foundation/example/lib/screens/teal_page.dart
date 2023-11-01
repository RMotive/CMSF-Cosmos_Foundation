import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:cosmos_foundation/helpers/router.dart' as hr;
import 'package:example/config/routes/routes.dart';
import 'package:example/screens/init_page.dart';
import 'package:flutter/material.dart';

// --> Helpers
final hr.Router _router = hr.Router.i;

class TealPage extends CosmosPage {
  const TealPage({super.key})
      : super(
          tealRoute,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
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

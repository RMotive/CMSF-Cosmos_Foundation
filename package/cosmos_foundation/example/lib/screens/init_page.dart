import 'package:cosmos_foundation/contracts/cosmos_page.dart';
import 'package:example/config/routes/routes.dart';
import 'package:example/screens/bluegrey_page.dart';
import 'package:example/screens/teal_page.dart';
import 'package:flutter/material.dart';
import 'package:cosmos_foundation/helpers/router.dart' as hr;

// --> Helpers
final hr.Router _router = hr.Router.i;

class InitPage extends CosmosPage {
  const InitPage({super.key})
      : super(
          initRoute,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: const ButtonStyle(
                // ignore: always_specify_types
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
              ),
              onPressed: () => _router.routeTo(
                const BluegreyPage(),
              ),
              child: const Text('Go blue grey page'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
                ),
                onPressed: () => _router.routeTo(
                  const TealPage(),
                ),
                child: const Text('Go teal page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

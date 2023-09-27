import 'package:cosmos_foundation/helpers/platform.dart';
import 'package:cosmos_foundation/widgets/conditionals/platform_condition_widget.dart';
import 'package:flutter/material.dart';

class PlatformConditionWidgetScreen extends StatelessWidget {
  const PlatformConditionWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Center(
            child: Text(
              'Platform Condition Widget',
              style: theme.primaryTextTheme.titleLarge?.apply(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('This widget allows to automatically choose the correct widget depending on the current platform context.'),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          child: PlatformConditionWidget(
            mobileValue: _ExampleCaseWidget(
              backgroundColor: Colors.blue.shade100,
              fontColor: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}

class _ExampleCaseWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color fontColor;
  const _ExampleCaseWidget({
    required this.backgroundColor,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Right now you are in: ${Platform.i.context.name} turn on another device to check its platform and the widget difference',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

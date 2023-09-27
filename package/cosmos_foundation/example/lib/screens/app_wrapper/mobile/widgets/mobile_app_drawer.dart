part of '../../app_wrapper.dart';

class _MobileAppDrawer extends StatelessWidget {
  const _MobileAppDrawer();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Map<String, Map<String, String>> buttons = <String, Map<String, String>>{
      "Conditionals": <String, String>{
        "Platform Conditional Widget": "/platform-conditional-widget",
        "System Conditional Widget": "",
      },
    };

    return SizedBox(
      child: Align(
        alignment: Alignment.centerRight,
        child: ColoredBox(
          color: theme.colorScheme.background,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            height: double.maxFinite,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              12,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          child: Text(
                            "Widgets",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 20,
                        right: 20,
                      ),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (MapEntry section in buttons.entries)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section.key,
                                    style: theme.textTheme.titleMedium?.apply(
                                      fontStyle: FontStyle.italic,
                                      fontWeightDelta: 200,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        for (MapEntry button in section.value.entries)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4,
                                            ),
                                            child: SizedBox(
                                              width: double.maxFinite,
                                              child: Builder(
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Scaffold.of(context).closeEndDrawer();
                                                      navigatorHandler.currentState?.push(
                                                        MaterialPageRoute(
                                                          builder: (context) => const PlatformConditionWidgetScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color: theme.colorScheme.surface,
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                          vertical: 8,
                                                          horizontal: 12,
                                                        ),
                                                        child: Text(
                                                          button.key,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

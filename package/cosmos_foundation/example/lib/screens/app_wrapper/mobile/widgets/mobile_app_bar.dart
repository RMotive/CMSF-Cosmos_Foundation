part of '../../app_wrapper.dart';

final AppBar _mobileAppBar = AppBar(
  centerTitle: true,
  actions: <Widget>[
    Builder(
      builder: (context) {
        return IconButton(
          icon: const Icon(Icons.widgets),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        );
      },
    ),
  ],
  title: Builder(
    builder: (context) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Cosmos Foundation Showcase",
          spellOut: true,
          style: const TextStyle(
            overflow: TextOverflow.visible,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: "\n(${defaultTargetPlatform.name})",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    },
  ),
);

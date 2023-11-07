import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

/// Stores the provate reference for the static change notifier for the Theming handling.
///
/// NOTE: DONT USE DIRECTLY THIS TO NOTIFY ALL LISTENERS ABOUT A CHANGE.
ValueNotifier<CosmosThemeBase>? _notifier;

/// Stores the private reference for the static theme collections provided by the configuration.
List<CosmosThemeBase> _themes = <CosmosThemeBase>[];

/// Validates and returns the correct object to handle listeners notifications when the
/// theme has changed.
ValueNotifier<CosmosThemeBase> get _validNotifier {
  if (_notifier == null) throw Exception("Theme is not initialized yet");
  return _notifier as ValueNotifier<CosmosThemeBase>;
}

/// Indicates to the global theme manager change and update all listeners
/// about the update of the current theme to use.
void updateTheme<TTheme extends CosmosThemeBase>(
  String themeIdentifier, {
  String? saveLocalKey,
}) {
  if (saveLocalKey != null) {
    final LocalStorage store = LocalStorage(saveLocalKey);
    store.ready.then((bool value) {
      if (value) {
        store.setItem(
          saveLocalKey,
          themeIdentifier,
          (Object nonEncodable) => <String, Object>{saveLocalKey: nonEncodable},
        );
      }
    });
  }
  CosmosThemeBase? base = _themes.where((CosmosThemeBase element) => element.themeIdentifier == themeIdentifier).firstOrNull;
  if (base == null) throw Exception('The identifier wasn\'t found in the themes subscribed');
  _validNotifier.value = base;
}

/// Looks for local storaged references about the theme selected by the user
/// to use it.
///
/// If the theme reference is found will return a Theme Base reference.
Future<TTheme?> getThemeFromStore<TTheme extends CosmosThemeBase>(
  String storeKey, {
  List<TTheme>? forcedThemes,
}) async {
  if (forcedThemes != null && forcedThemes.isNotEmpty) _themes = forcedThemes;
  if (_themes.isEmpty) throw Exception('No theme collection initialized, use property forcedThemes to subscribe the collection');
  final LocalStorage store = LocalStorage(storeKey);
  await store.ready;
  Map<String, dynamic>? isMapped = store.getItem(storeKey);
  if (isMapped == null || !isMapped.containsKey(storeKey)) return null;
  String themeStoredIdentifier = isMapped[storeKey];
  for (CosmosThemeBase theme in _themes) {
    if (theme.themeIdentifier == themeStoredIdentifier) return theme as TTheme;
  }

  return null;
}

/// Looks for the current theme subscribed and being handled for the global theme notifier manager.
/// This doesn't look for the [CosmosThemeBase] reference from a persistive way, this just will return
/// the theme reference previously init by application initialization.
///
/// [updateEffect] Will subscribe a listener to the theme changer manager and will trigger your setState function
/// provided to update your [StatefulWidget] state after the widget state was did setup and the theme as well.
/// after the subscription of the [updateEffect] ensure add the [disposeGetTheme] on your [dispose] method to remove the
/// listener and ensure the application performance and avoid any ilogical behavior from the framework work pipeline.
///
/// IMPORTANT NOTE: Avoid the use of [updateEffect] on [StatelessWidget]. This subscription is only
/// considered to notify the current theme change to [StatefulWidget] that doesn't update its state after the application
/// gets restarted by the theme notifier handler.
///
/// RECOMMENDED USE (For [StatefulWidget]):
/// '''dart
///   "State"
///   late CosmosThemeBase theme;
///
///   @override
///   void initState() {
///     super.initState();
///     theme = getTheme<ThemeBase>(
///       updateEffect: updateThemeEffect
///     );
///   }
///
///   @override
///   void dispose() {
///     disposeGetTheme(updateThemeEffect);
///     super.dispose();
///   }
///   void updateThemeEffect(ThemeBase effect) => setState(() {});
/// '''
TTheme getTheme<TTheme extends CosmosThemeBase>({void Function(TTheme effect)? updateEfect}) {
  if (updateEfect != null) {
    _validNotifier.addListener(() => updateEfect(_validNotifier.value as TTheme));
  }
  return _validNotifier.value as TTheme;
}

/// Will remove the [updateEffect] subscribed on [getTheme] for [StatefulWidget] that
/// use the theme listening functions.
///
/// [disposeEffect] the subscribed function to be removed from the notifier manager stack.
///
/// RECOMMENDED USE (For [StatefulWidget]):
/// '''dart
///   "State"
///   late CosmosThemeBase theme;
///
///   @override
///   void initState() {
///     super.initState();
///     theme = getTheme<ThemeBase>(
///       updateEffect: updateThemeEffect
///     );
///   }
///
///   @override
///   void dispose() {
///     disposeGetTheme(updateThemeEffect);
///     super.dispose();
///   }
///   void updateThemeEffect(ThemeBase effect) => setState(() {});
/// '''
void disposeGetTheme<TTheme extends CosmosThemeBase>(void Function(TTheme effect) disposeEffect) {
  _validNotifier.removeListener(() => disposeEffect(_validNotifier.value as TTheme));
}

/// Provides a global reference for the theme change manager.
///
/// NOTE: Preferrely avoid use it, use it just in specific complex cases, if you have
/// a [StatefulWidget] that needs update the theme after a change and after its state is setup.
/// you can subscribe an [updateEffect] to the method [getTheme] as the next example:
/// ```dart
///   CosmosThemeBase? theme = getTheme(
///     updateEffect: setState(() => {{ `your state update` }}),
///   );
/// ```
///
///
/// RECOMMENDED USE (For [StatefulWidget]):
/// '''dart
///   "State"
///   late CosmosThemeBase theme;
///
///   @override
///   void initState() {
///     super.initState();
///     theme = getTheme<ThemeBase>(
///       updateEffect: updateThemeEffect
///     );
///   }
///
///   @override
///   void dispose() {
///     disposeGetTheme(updateThemeEffect);
///     super.dispose();
///   }
///   void updateThemeEffect(ThemeBase effect) => setState(() {});
/// '''
ValueNotifier<CosmosThemeBase> get listenTheme => _validNotifier;

void initTheme<TThemeBase extends CosmosThemeBase>(TThemeBase? defaultTheme, List<TThemeBase> themes) {
  _themes = themes;
  _Theme.loadTheme(defaultTheme);
}

final class _Theme<TThemeBase extends CosmosThemeBase> {
  static _Theme<CosmosThemeBase>? ins;

  late final TThemeBase? _defaultTheme;
  TThemeBase get defaultTheme {
    if (_defaultTheme == null) throw Exception("The theme is not configured");
    return _defaultTheme as TThemeBase;
  }

  _Theme._(TThemeBase? defaultTheme) {
    if (defaultTheme == null) return;
    _defaultTheme = defaultTheme;
  }

  static loadTheme<TThemeBase extends CosmosThemeBase>(TThemeBase? defaultTheme) {
    _Theme<CosmosThemeBase> manager = ins ?? _Theme<TThemeBase>._(defaultTheme);
    ins = manager;
    _notifier = ValueNotifier<CosmosThemeBase>(manager.defaultTheme);
  }
}

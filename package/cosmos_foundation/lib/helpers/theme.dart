import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

ValueNotifier<CosmosThemeBase>? _notifier;
ValueNotifier<CosmosThemeBase> get _validNotifier {
  if (_notifier == null) throw Exception("Theme is not initialized yet");
  return _notifier as ValueNotifier<CosmosThemeBase>;
}

void updateTheme<TTheme extends CosmosThemeBase>(
  TTheme updateTheme, {
  String? saveLocalKey,
}) {
  if (saveLocalKey != null) {
    final LocalStorage store = LocalStorage(saveLocalKey);
    store.ready.then((value) {
      if (value) store.setItem(saveLocalKey, updateTheme);
    });
  }
  _validNotifier.value = updateTheme;
}

TTheme getTheme<TTheme extends CosmosThemeBase>({String? getFromStore}) {
  if (getFromStore != null) {
    final LocalStorage store = LocalStorage(getFromStore);
    store.ready.then((value) {
      if (value) return store.getItem(getFromStore) as TTheme;
    });
  }
  return _validNotifier.value as TTheme;
}

ValueNotifier<TThemeBase> listenTheme<TThemeBase extends CosmosThemeBase>() => _validNotifier as ValueNotifier<TThemeBase>;

void initTheme<TThemeBase extends CosmosThemeBase>(TThemeBase? defaultTheme) {
  _Theme.loadTheme(defaultTheme);
}

final class _Theme<TThemeBase extends CosmosThemeBase> {
  static _Theme? ins;

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
    _Theme manager = ins ?? _Theme._(defaultTheme);
    ins = manager;
    _notifier = ValueNotifier(manager.defaultTheme);
  }
}

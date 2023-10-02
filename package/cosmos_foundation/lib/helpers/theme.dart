import 'package:cosmos_foundation/contracts/cosmos_theme_base.dart';
import 'package:flutter/material.dart';

ValueNotifier<CosmosThemeBase>? _notifier;
ValueNotifier<CosmosThemeBase> get _validNotifier {
  if (_notifier == null) throw Exception("Theme is not initialized yet");
  return _notifier as ValueNotifier<CosmosThemeBase>;
}

void updateTheme<TTheme extends CosmosThemeBase>(TTheme updateTheme) => _validNotifier.value = updateTheme;

TTheme getTheme<TTheme extends CosmosThemeBase>() => _validNotifier.value as TTheme;

ValueNotifier<TThemeBase> listenTheme<TThemeBase extends CosmosThemeBase>() => _validNotifier as ValueNotifier<TThemeBase>;

void initTheme<TThemeBase extends CosmosThemeBase, TTheme extends TThemeBase>(TTheme? defaultTheme, List<TTheme>? themes) {
  _Theme.loadTheme(defaultTheme, themes);
}

final class _Theme<TThemeBase extends CosmosThemeBase, TTheme extends TThemeBase> {
  static _Theme? ins;

  late final TTheme? _defaultTheme;
  TTheme get defaultTheme {
    if (_defaultTheme == null) throw Exception("The theme is not configured");
    return _defaultTheme as TTheme;
  }

  late final List<TTheme>? _themes;
  List<TTheme> get themes {
    if (_themes == null || _themes!.isEmpty) throw Exception("The theme is not configured");
    return _themes as List<TTheme>;
  }

  _Theme._(TTheme? defaultTheme, List<TTheme>? themes) {
    if (defaultTheme == null && themes != null) return;
    if (defaultTheme != null) _defaultTheme = defaultTheme;
    if (defaultTheme == null && (themes != null && themes.isNotEmpty)) _defaultTheme = themes[0];
    return;
  }

  static loadTheme<TThemeBase extends CosmosThemeBase, TTheme extends TThemeBase>(TTheme? defaultTheme, List<TTheme>? themes) {
    _Theme manager = ins ?? _Theme._(defaultTheme, themes);
    ins = manager;
    _notifier = ValueNotifier(manager.defaultTheme);
  }
}

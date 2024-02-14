import 'package:cosmos_foundation/alias/aliases.dart';

/// Provides utilities to handle jObjects such read and write.
mixin class Jobject {
  /// Binds an specified property into the gathered json.
  ///
  /// [json] The json object to scrap in.
  ///
  /// [fallbacks] The specified keys to search into the json.
  ///   It will be used in the order it is given, if the first key does't found any, then will be used the another one.
  ///
  /// [defaultValue] The specified default value to return if all the fallbacks resulted in a null value.
  ///
  /// [caseSensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  TExpectation bindProperty<TExpectation>(JObject json, List<String> fallbacks, TExpectation defaultValue, {bool caseSensitive = true}) {
    TExpectation? gatheredValue;
    for (String key in fallbacks) {
      for (JElement element in json.entries) {
        final String currentElementKey = element.key;
        if (caseSensitive && (currentElementKey != key)) continue;
        if (!caseSensitive && (currentElementKey.toLowerCase() != key.toLowerCase())) continue;
        gatheredValue = (element.value as TExpectation);
        break;
      }
      if (gatheredValue != null) break;
    }
    return gatheredValue ?? defaultValue;
  }
}

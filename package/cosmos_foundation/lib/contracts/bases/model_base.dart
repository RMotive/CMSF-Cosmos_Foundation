import 'package:cosmos_foundation/alias/aliases.dart';

/// Generates a contract to handle model base abstraction that enforce the use
/// of model tools to handle ease convertions.
abstract class ModelBase {
  const ModelBase();

  /// Converts the current object to a json object.
  JObject toJson();
}

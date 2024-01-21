import 'package:cosmos_foundation/models/structs/cosmos_uri_struct.dart';
import 'package:flutter/foundation.dart';

abstract class CosmosRepository {
  late final CosmosUriStruct host;
  final CosmosUriStruct production;
  final CosmosUriStruct? development;

  CosmosRepository(
    this.production, {
    this.development,
  }) {
    host = kDebugMode ? (development ?? production) : production;
  }
}

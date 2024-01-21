import 'package:cosmos_foundation/models/structs/cosmos_uri_struct.dart';

abstract class CosmosRepository {
  final CosmosUriStruct host;

  const CosmosRepository(this.host);
}

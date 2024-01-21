import 'package:cosmos_foundation/models/structs/cosmos_uri_struct.dart';

abstract class CosmosService {
  late final CosmosUriStruct endpoint;

  CosmosService(CosmosUriStruct host, String servicePath) {
    endpoint = CosmosUriStruct.includeEndpoint(host, servicePath);
  }
}

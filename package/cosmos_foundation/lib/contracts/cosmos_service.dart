import 'dart:convert';
import 'package:http/http.dart';

import 'package:cosmos_foundation/models/structs/cosmos_uri_struct.dart';

abstract class CosmosService {
  late final CosmosUriStruct endpoint;
  late final Client comm;

  CosmosService(CosmosUriStruct host, String servicePath) {
    endpoint = CosmosUriStruct.includeEndpoint(host, servicePath);
    comm = Client();
  }

  Future<TOutput> get<TOutput>(String path) async {
    Uri url = endpoint.generateUri();
    Response request = await comm.get(url);
    if (request.statusCode != 200) throw 'Wrong server answer';
    String rawResponse = request.body;
    TOutput decodedResponse = jsonDecode(rawResponse);
    return decodedResponse;
  }
}

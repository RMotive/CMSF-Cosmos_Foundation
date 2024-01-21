import 'dart:convert';
import 'dart:io';

import 'package:cosmos_foundation/models/structs/cosmos_uri_struct.dart';

abstract class CosmosService {
  late final CosmosUriStruct endpoint;
  late final HttpClient comm;

  CosmosService(CosmosUriStruct host, String servicePath) {
    endpoint = CosmosUriStruct.includeEndpoint(host, servicePath);
    comm = HttpClient();
  }

  Future<TOutput> get<TOutput>(String path) async {
    Uri url = endpoint.generateUri();
    HttpClientRequest request = await comm.get(url.host, url.port, url.path);
    HttpClientResponse response = await request.close();
    String rawResponse = await response.transform(utf8.decoder).join();
    TOutput decodedResponse = jsonDecode(rawResponse);
    return decodedResponse;
  }
}

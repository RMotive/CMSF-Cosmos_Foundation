import 'dart:convert';

import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/contracts/interfaces/i_model.dart';
import 'package:cosmos_foundation/foundation/services/service_result.dart';
import 'package:http/http.dart';

import 'package:cosmos_foundation/models/structs/cosmos_uri_struct.dart';

abstract class CosmosService {
  late final CosmosUriStruct endpoint;
  late final Client comm;

  CosmosService(CosmosUriStruct host, String servicePath) {
    endpoint = CosmosUriStruct.includeEndpoint(host, servicePath);
    comm = Client();
  }

  Future<ServiceResult> post<S, E>(
    String operation,
    IModel request, {
    Map<String, String>? headers,
  }) async {
    Uri uri = endpoint.generateUri(endpoint: operation);
    try {
      Response response = await comm.post(
        uri,
        headers: headers,
        body: jsonEncode(request),
      );
      JObject parsedBody = jsonDecode(response.body);

      if (response.statusCode != 200) return ServiceResult(error: parsedBody);
      return ServiceResult(success: parsedBody);
    } catch (x, st) {
      return ServiceResult(exception: x, trace: st);
    }
  }
}
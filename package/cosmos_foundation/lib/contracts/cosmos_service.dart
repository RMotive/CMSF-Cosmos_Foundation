import 'dart:convert';

import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/contracts/interfaces/i_model.dart';
import 'package:cosmos_foundation/foundation/services/operation_result.dart';
import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

import 'package:cosmos_foundation/models/structs/cosmos_uri_struct.dart';

typedef Headers = Map<String, String>;

abstract class CosmosService {
  late final CosmosUriStruct endpoint;
  late final Client comm;

  static const Headers _kHeaders = <String, String>{
    "accept-type": 'application/json',
    "content-type": 'application/json',
  };

  CosmosService(CosmosUriStruct host, String servicePath) {
    endpoint = CosmosUriStruct.includeEndpoint(host, servicePath);
    comm = kIsWeb ? BrowserClient() : Client();   
  }

  Future<OperationResult> post<S, E>(
    String operation,
    IModel request, {
    Headers? headers,
  }) async {
    Uri uri = endpoint.generateUri(endpoint: operation);
    try {
      final Response response = await comm.post(
        uri,
        headers: headers ?? _kHeaders,
        body: jsonEncode(request),
      );
      final JObject parsedBody = jsonDecode(response.body);
      final int statusCode = response.statusCode;
      if (response.statusCode == 200) return OperationResult(success: parsedBody, statusCode: 200);
      return OperationResult(error: parsedBody, statusCode: statusCode);
    } catch (x, st) {
      return OperationResult(exception: x, trace: st);
    }
  }
}

import 'package:cosmos_foundation/enumerators/cosmos_protocols.dart';

class CosmosUriStruct {
  final CosmosProtocols protocol;
  final String host;
  final String path;
  final int? port;
  final Map<String, dynamic>? qryParams;

  const CosmosUriStruct(
    this.host,
    this.path, {
    this.port, 
    this.qryParams,
    this.protocol = CosmosProtocols.https,
  });

  factory CosmosUriStruct.includeEndpoint(CosmosUriStruct source, String endpoint) {
    return CosmosUriStruct(
      source.host,
      '${source.path}/$endpoint',
      port: source.port,
      qryParams: source.qryParams,
      protocol: source.protocol,
    );
  }

  Uri generateUri({String? endpoint}) {
    String buildtEndpoint = path;
    if (endpoint != null) buildtEndpoint += '/$endpoint';

    return Uri(
      scheme: protocol.scheme,
      host: host,
      path: buildtEndpoint,
      port: port,
      queryParameters: qryParams,
    );
  }
}

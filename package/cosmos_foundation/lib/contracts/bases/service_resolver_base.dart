import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/foundation/services/operation_result.dart';

/// Creates a base contract to generate easy handlers for custom service resolvers.
abstract class ServiceResolverBase<TSuccess> {
  /// The result of the specified http operation handled by a [CosmosService] abstarct contract methods.
  final OperationResult operationResult;
  /// The factory to generate the expected success model based on the json object gathered.
  final TSuccess Function(JObject json) factory;

  ///  Creates the instance of the base contract class object that handles the abstraction for a service resolver
  ///  ensuring an ease use of custom resolvers.
  const ServiceResolverBase(
    this.operationResult, {
    required this.factory,
  });
}

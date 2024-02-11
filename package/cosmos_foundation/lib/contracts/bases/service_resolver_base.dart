import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/foundation/services/operation_result.dart';

abstract class ServiceResolverBase<TSuccess> {
  final OperationResult operationResult;
  final TSuccess Function(JObject json) factory;

  const ServiceResolverBase(
    this.operationResult, {
    required this.factory,
  });
}

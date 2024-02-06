
import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/foundation/services/operation_result.dart';

class ServiceResult<S> {
  late final OperationResult _result;
  late final S Function(JObject json) _factory;

  ServiceResult(OperationResult result, S Function(JObject json) factory) {
    _result = result;
    _factory = factory;
  }

  void resolve(
    Function(S success) onSuccess,
    Function(JObject failure, int statusCode) onFailure,
    Function(Object exception, StackTrace trace) onException,
  ) {
    _result.resolve(
      (JObject success) => onSuccess(_factory(success)),
      (JObject failure, int statusCode) => onFailure(failure, statusCode),
      (Object exception, StackTrace trace) => onException(exception, trace),
    );
  }
}

import 'package:cosmos_foundation/alias/aliases.dart';

class ServiceResult {
  late final JObject? _successResult;
  late final JObject? _errorResult;
  late final Object? _exception;
  late final StackTrace? _tracer;

  ServiceResult({JObject? success, JObject? error, Object? exception, StackTrace? trace}) {
    _successResult = success;
    _errorResult = error;
    _exception = exception;
    _tracer = trace;
  }

  void resolve(Function(JObject) onSucess, Function(JObject) onFailure, Function(Object, StackTrace) onException) {
    if (_successResult != null) onSucess(_successResult as JObject);
    if (_errorResult != null) onFailure(_errorResult as JObject);

    Object evaluatedX = _exception ?? Exception("No success, no error, no exception");
    StackTrace evaluatedST = _tracer ?? StackTrace.current;
    onException(evaluatedX, evaluatedST);
  }
}

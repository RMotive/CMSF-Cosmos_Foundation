import 'package:cosmos_foundation/alias/aliases.dart';

class OperationResult {
  late final JObject? _successResult;
  late final JObject? _errorResult;
  late final Object? _exception;
  late final StackTrace? _tracer;
  late final int? _statusCode;

  OperationResult({JObject? success, JObject? error, Object? exception, StackTrace? trace, int? statusCode}) {
    _successResult = success;
    _errorResult = error;
    _exception = exception;
    _tracer = trace;
    _statusCode = statusCode;
  }

  void resolve(
    Function(JObject success) onSucess,
    Function(JObject failure, int statusCode) onFailure,
    Function(Object exception, StackTrace trace) onException,
  ) {
    if (_successResult != null) onSucess(_successResult as JObject);
    if (_errorResult != null) onFailure(_errorResult as JObject, _statusCode ?? 0);

    Object evaluatedX = _exception ?? Exception("No success, no error, no exception");
    StackTrace evaluatedST = _tracer ?? StackTrace.current;
    onException(evaluatedX, evaluatedST);
  }
}

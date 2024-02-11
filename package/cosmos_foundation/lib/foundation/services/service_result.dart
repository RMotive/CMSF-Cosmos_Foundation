
import 'package:cosmos_foundation/alias/aliases.dart';
import 'package:cosmos_foundation/foundation/services/operation_result.dart';
import 'package:cosmos_foundation/helpers/advisor.dart';

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
    Function(Object exception, StackTrace trace) onException, {
    bool advisor = true,
  }) {
    Advisor? mAdvisor;
    if (advisor) {
      mAdvisor = const Advisor('SERVICE-RESULT');
    }

    _result.resolve(
      (JObject success) {
        onSuccess(_factory(success));
        if (mAdvisor != null) {
          mAdvisor.adviseSuccess(
            'Success service result',
            info: success,
          );
        }
      },
      (JObject failure, int statusCode) {
        onFailure(failure, statusCode);
        if (mAdvisor != null) {
          mAdvisor.adviseWarning(
            'Failure service result',
            info: failure,
          );
        }
      },
      (Object exception, StackTrace trace) {
        onException(exception, trace);
      },
    );
  }
}

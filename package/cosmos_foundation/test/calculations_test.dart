import 'package:cosmos_foundation/helpers/calculations.dart';
import 'package:cosmos_foundation/models/structs/clamp_constraints.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  setUp(() {});
  test(
    'Advance clamp calculation working',
    () {
      const ClampConstraints constraints = ClampConstraints(0, 100, 0, 100);

      final double opResult = calSlicedThreshold(10, constraints);

      assert(opResult == 10, '($opResult) Should be 10');
    },
  );
}

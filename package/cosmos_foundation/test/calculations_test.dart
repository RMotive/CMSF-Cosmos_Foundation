import 'package:cosmos_foundation/helpers/responsive.dart';
import 'package:cosmos_foundation/models/structs/clamp_ratio_constraints.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  setUp(() {});
  test(
    'Advance clamp calculation working',
    () {
      const ClampRatioConstraints constraints = ClampRatioConstraints(0, 100, 0, 100);

      final double opResult = Responsive.clampRatio(10, constraints);

      assert(opResult == 10, '($opResult) Should be 10');
    },
  );
}

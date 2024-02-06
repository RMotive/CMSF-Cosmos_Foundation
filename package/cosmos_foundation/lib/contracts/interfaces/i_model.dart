import 'package:cosmos_foundation/contracts/interfaces/i_scheme.dart';

abstract interface class ModelInterface<TScheme extends IScheme> extends IModel {
  TScheme generateScheme();
}

abstract interface class IModel {}

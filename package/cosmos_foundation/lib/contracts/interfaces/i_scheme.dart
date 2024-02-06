import 'package:cosmos_foundation/contracts/interfaces/i_model.dart';

abstract interface class SchemeInterface<TModel extends IModel> extends IScheme {
  TModel generateModel();
}

abstract interface class IScheme {}

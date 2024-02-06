import 'package:cosmos_foundation/contracts/interfaces/i_model.dart';

abstract interface class SchemeInterface<TModel extends IModel> extends IScheme {
  TModel generateModel();
  Map<String, dynamic> toJson();
}

abstract interface class IScheme {}

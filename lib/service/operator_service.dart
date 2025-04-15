import '../model/operator_model.dart';
import '../entity/operator_entity.dart';

class OperatorService {

  final OperatorModel _model = OperatorModel();

  Future<List<Operator>> getAvailableOperators() async {
    return await _model.getOperators();
  }
}
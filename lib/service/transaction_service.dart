import '../entity/transaction_entity.dart';
import '../model/transaction_model.dart';

class TransactionService {
  final TransactionModel _model = TransactionModel();

  Future<void> makePayment(TransactionRequest request) async {
    await _model.makeTransaction(request);
  }
}
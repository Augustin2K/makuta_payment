import '../model/wallet_model.dart';
import '../entity/wallet_entity.dart';

class WalletService {
  final WalletModel _model = WalletModel();

  /// Récupère tous les wallets pouvant recevoir de l'argent
  Future<List<Wallet>> getReceivableWallets() async {
    return await _model.getReceivableWallets();
  }

  /// Récupère un wallet spécifique à partir de son ID
  Future<Wallet> getWalletById(int id) async {
    try {
      final wallets = await getReceivableWallets();
      return wallets.firstWhere((w) => w.id == id);
    } catch (e) {
      throw Exception('❌ Wallet avec l’ID $id non trouvé');
    }
  }
}

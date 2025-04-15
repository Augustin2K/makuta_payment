import '../config/RestClient.dart';
import '../model/auth_model.dart';

class AuthService {
  final AuthModel _model = AuthModel();

  /// Authentifie l’utilisateur et stocke le token dans RestClient
  Future<void> login(String username, String password) async {
    try {
      final token = await _model.authenticate(username, password);
      RestClient.userToken = token;
      print("✅ Token enregistré dans RestClient !");
    } catch (e) {
      print("❌ Erreur lors de l'authentification : $e");
      rethrow;
    }
  }

  /// Vérifie si l'utilisateur est déjà connecté
  bool isAuthenticated() {
    return RestClient.userToken != null && RestClient.userToken!.isNotEmpty;
  }
}

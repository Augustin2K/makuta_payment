import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:makuta_payment/config/RestClient.dart';
import '../entity/wallet_entity.dart';

class WalletModel {
  final String baseUrl = RestClient.baseUrl;
  final String version = RestClient.makuta_version;
  final String appToken = RestClient.appId;

  /// Récupère les wallets pouvant recevoir de l'argent
  Future<List<Wallet>> getReceivableWallets() async {
    final userToken = RestClient.userToken;

    if (userToken == null || userToken.isEmpty) {
      throw Exception('❌ Le Bearer Token est manquant !');
    }

    final url = Uri.parse('$baseUrl/api/v2/wallet/can-receive-money');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $userToken',
        'App-Token': appToken,
        'Content-Type': 'application/json',
      },
    );

    print('📡 [WalletModel] STATUS: ${response.statusCode}');
    print('📦 BODY: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final List<dynamic> decoded = jsonDecode(response.body);
        return decoded.map((json) => Wallet.fromJson(json)).toList();
      } catch (e) {
        print('❌ Erreur parsing JSON wallet : $e');
        throw Exception('Erreur de lecture des wallets');
      }
    } else {
      throw Exception('Erreur API (${response.statusCode}) : ${response.body}');
    }
  }
}

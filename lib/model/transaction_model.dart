import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:makuta_payment/config/RestClient.dart';
import '../entity/transaction_entity.dart';

class TransactionModel {
  final String baseUrl = RestClient.baseUrl;
  final String appToken = RestClient.appId;
  final String version = RestClient.makuta_version;
  final String userToken = RestClient.userToken!;

  Future<void> makeTransaction(TransactionRequest trx) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$version/financial-transactions/0'),
      headers: {
        'Authorization': 'Bearer $userToken',
        'App-Token': appToken,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(trx.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur transaction : ${response.statusCode}');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:makuta_payment/config/RestClient.dart';
import '../entity/operator_entity.dart';

class OperatorModel {
  final String baseUrl = RestClient.baseUrl;
  final String appToken = RestClient.appId;
  final String version = RestClient.makuta_version;
  final String userToken = RestClient.userToken!;

  Future<List<Operator>> getOperators() async {
    final response = await http.get(
      Uri.parse('$baseUrl/$version/financial-corporation/receive-request'),
      headers: {
        'Authorization': 'Bearer $userToken',
        'App-Token': appToken,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Operator>.from(
        data.map((json) => Operator.fromJson(json)),
      );
    } else {
      throw Exception('Erreur chargement opérateurs');
    }
  }
}

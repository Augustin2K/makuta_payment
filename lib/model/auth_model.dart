import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:makuta_payment/config/RestClient.dart';

class AuthModel {
  final String baseUrl = RestClient.baseUrl;
  final String appToken = RestClient.appId;

  Future<String> authenticate(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login/token'),
      headers: {
        'App-Token': appToken,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    print('STATUS CODE : ${response.statusCode}');
    print('RESPONSE BODY : ${response.body}');
    print('HEADERS : ${response.headers}');
    print('HEADERS token : ${response.headers['user-token']}');

    if (response.statusCode == 200) {
      final token = response.headers['user-token'];
      if (token != null && token.isNotEmpty) {
        return token;
      } else {
        throw Exception("❌ Token introuvable dans les headers.");
      }
    } else {
      throw Exception(
          "❌ Authentification échouée : ${response.statusCode} - ${response
              .body}");
    }
  }
}
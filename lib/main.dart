import 'package:flutter/material.dart';
import 'screen/login_screen.dart';

void main() {
  runApp(const PayMakutaApp());
}

class PayMakutaApp extends StatelessWidget {
  const PayMakutaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PayMakuta',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // 🔐 Démarre sur l’écran de connexion
    );
  }
}
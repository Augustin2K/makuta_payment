import 'package:flutter/material.dart';
import 'login_screen.dart'; //

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue sur PayMakuta'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: const Text('Se connecter'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../entity/operator_entity.dart';
import '../entity/wallet_entity.dart';
import '../service/operator_service.dart';
import '../service/wallet_service.dart';
import '../config/RestClient.dart';
import 'payment_screen.dart';

class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

class _OperatorScreenState extends State<OperatorScreen> {
  final OperatorService _operatorService = OperatorService();
  final WalletService _walletService = WalletService();
  List<Operator> operators = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOperators();
  }

  Future<void> _loadOperators() async {
    try {
      final data = await _operatorService.getAvailableOperators();
      setState(() {
        operators = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur chargement opérateurs : $e')),
      );
    }
  }

  void _showPaymentDialog(Operator operator) async {
    try {
      final wallet = await _walletService.getWalletById(RestClient.defaultWalletId);
      final TextEditingController amountController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Paiement - Détails'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Montant à payer (${wallet?.currency.acronym})',
                ),
              ),
              const SizedBox(height: 10),
              Text("Opérateur : ${operator.label.isNotEmpty ? operator.label : '---'}"),
              Text("Wallet : ${wallet.label.isNotEmpty ? wallet?.label : '---'}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                final parsedAmount = double.tryParse(amountController.text);
                if (parsedAmount == null || parsedAmount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Veuillez entrer un montant valide.")),
                  );
                  return;
                }
                Navigator.pop(context); // Fermer le dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      selectedOperator: operator,
                      amount: parsedAmount,
                      selectedWallet: wallet,
                    ),
                  ),
                );
              },
              child: const Text('Continuer'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur chargement wallet : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choisir un opérateur')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: operators.length,
        itemBuilder: (context, index) {
          final operator = operators[index];
          return ListTile(
            leading: Image.network(
              operator.icon,
              width: 40,
              height: 40,
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
            title: Text(operator.label.isNotEmpty ? operator.label : 'Opérateur'),
            onTap: () => _showPaymentDialog(operator),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../entity/operator_entity.dart';
import '../entity/wallet_entity.dart';
import '../entity/transaction_entity.dart';
import '../service/transaction_service.dart';

class PaymentScreen extends StatefulWidget {
  final Operator selectedOperator;
  final Wallet selectedWallet;
  final double amount;

  const PaymentScreen({
    super.key,
    required this.selectedOperator,
    required this.selectedWallet,
    required this.amount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final phoneController = TextEditingController();
  String? selectedCurrency;
  final TransactionService _transactionService = TransactionService();
  bool isLoading = false;

  void _submitPayment() async {
    if (phoneController.text.isEmpty || selectedCurrency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
      return;
    }

    setState(() => isLoading = true);

    final transaction = TransactionRequest(
      wallet: widget.selectedWallet.id,
      walletOperation: 'CREDIT',
      walletAmount: widget.amount,
      clientOperator: widget.selectedOperator.apiKey,
      clientCurrency: selectedCurrency!,
      clientAccountNumber: phoneController.text,
      reason: "Paiement Makuta",
      isPreview: false,
      makeC2B: true,
      thirdPartyReference: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    try {
      await _transactionService.makePayment(transaction);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Paiement envoyé avec succès.")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirmation du paiement")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Numéro du client"),
            ),
            DropdownButtonFormField<String>(
              value: selectedCurrency,
              items: widget.selectedOperator.currencies
                  .map((c) => DropdownMenuItem(
                value: c.acronym,
                child: Text("${c.label} (${c.acronym})"),
              ))
                  .toList(),
              onChanged: (val) => setState(() => selectedCurrency = val),
              decoration: const InputDecoration(labelText: "Devise du client"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Retour"),
                ),
                ElevatedButton.icon(
                  onPressed: _submitPayment,
                  icon: const Icon(Icons.send),
                  label: const Text("Payer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

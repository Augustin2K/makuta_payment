class WalletCurrency {
  final String label;
  final String acronym;

  WalletCurrency({required this.label, required this.acronym});

  factory WalletCurrency.fromJson(Map<String, dynamic> json) {
    return WalletCurrency(
      label: json['label'],
      acronym: json['acronym'],
    );
  }
}

class WalletCorporationCategory {
  final int id;
  final String label;

  WalletCorporationCategory({required this.id, required this.label});

  factory WalletCorporationCategory.fromJson(Map<String, dynamic> json) {
    return WalletCorporationCategory(
      id: json['id'],
      label: json['label'],
    );
  }
}

class WalletCorporation {
  final String label;
  final String compagny;
  final String apiKey;
  final String icon;
  final WalletCorporationCategory category;

  WalletCorporation({
    required this.label,
    required this.compagny,
    required this.apiKey,
    required this.icon,
    required this.category,
  });

  factory WalletCorporation.fromJson(Map<String, dynamic> json) {
    return WalletCorporation(
      label: json['label'],
      compagny: json['compagny'],
      apiKey: json['apiKey'],
      icon: json['icon'],
      category: WalletCorporationCategory.fromJson(json['financialCorporationCategory']),
    );
  }
}

class Wallet {
  final int id;
  final String label;
  final String accountNumber;
  final WalletCorporation financialCorporation;
  final WalletCurrency currency;
  final bool isDisabled;

  Wallet({
    required this.id,
    required this.label,
    required this.accountNumber,
    required this.financialCorporation,
    required this.currency,
    required this.isDisabled,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    try {
      return Wallet(
        id: json['id'],
        label: json['label'],
        accountNumber: json['accountNumber'],
        financialCorporation: WalletCorporation.fromJson(json['financialCorporation']),
        currency: WalletCurrency.fromJson(json['currency']),
        isDisabled: json['isDisabled'] ?? false,
      );
    } catch (e) {
      print("Erreur Wallet.fromJson : $e\nJson reçu : $json");
      rethrow;
    }
  }

}

class OperatorCurrency {
  final String label;
  final String acronym;

  OperatorCurrency({required this.label, required this.acronym});

  factory OperatorCurrency.fromJson(Map<String, dynamic> json) {
    return OperatorCurrency(
      label: json['label'],
      acronym: json['acronym'],
    );
  }
}

class Operator {
  final int id;
  final String label;
  final String apiKey;
  final String icon;
  final List<OperatorCurrency> currencies;

  Operator({
    required this.id,
    required this.label,
    required this.apiKey,
    required this.icon,
    required this.currencies,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      label: json['label'],
      apiKey: json['apiKey'],
      icon: json['icon'],
      currencies: (json['currencies'] as List)
          .map((c) => OperatorCurrency.fromJson(c))
          .toList(),
    );
  }
}
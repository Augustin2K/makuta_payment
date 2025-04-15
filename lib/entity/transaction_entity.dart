class TransactionRequest {
  final int wallet;
  final String walletOperation;
  final double walletAmount;
  final String clientOperator;
  final String clientCurrency;
  final String clientAccountNumber;
  final String reason;
  final bool isPreview;
  final bool makeC2B;
  final String thirdPartyReference;

  TransactionRequest({
    required this.wallet,
    required this.walletOperation,
    required this.walletAmount,
    required this.clientOperator,
    required this.clientCurrency,
    required this.clientAccountNumber,
    required this.reason,
    required this.isPreview,
    required this.makeC2B,
    required this.thirdPartyReference,
  });

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "walletOperation": walletOperation,
    "walletAmount": walletAmount,
    "clientOperator": clientOperator,
    "clientCurrency": clientCurrency,
    "clientAccountNumber": clientAccountNumber,
    "reason": reason,
    "isPreview": isPreview,
    "makeC2B": makeC2B,
    "thirdPartyReference": thirdPartyReference,
  };
}

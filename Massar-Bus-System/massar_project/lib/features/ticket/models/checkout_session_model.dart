class CheckoutSessionModel {
  final String orderId;
  final String paymentMethod;
  final DateTime transactionDate;
  // In a real app, this would hold the BusTicketModel. For simplicity with routing,
  // we might pass it explicitly, but let's keep it in the session if needed.
  // We'll just define the core properties needed for success screen.

  CheckoutSessionModel({
    required this.orderId,
    required this.paymentMethod,
    required this.transactionDate,
  });

  // Example factory for API integration
  factory CheckoutSessionModel.fromJson(Map<String, dynamic> json) {
    return CheckoutSessionModel(
      orderId: json['orderId'] as String,
      paymentMethod: json['paymentMethod'] as String,
      transactionDate: DateTime.parse(json['transactionDate'] as String),
    );
  }
}

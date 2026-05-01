class CheckoutSessionModel {
  final String orderId;
  final String paymentMethod;
  final DateTime transactionDate;
  final String? passengerName;
  final String? passengerPhone;

  CheckoutSessionModel({
    required this.orderId,
    required this.paymentMethod,
    required this.transactionDate,
    this.passengerName,
    this.passengerPhone,
  });

  factory CheckoutSessionModel.fromJson(Map<String, dynamic> json) {
    return CheckoutSessionModel(
      orderId: json['orderId'] as String,
      paymentMethod: json['paymentMethod'] as String,
      transactionDate: DateTime.parse(json['transactionDate'] as String),
      passengerName: json['passengerName'] as String?,
      passengerPhone: json['passengerPhone'] as String?,
    );
  }
}

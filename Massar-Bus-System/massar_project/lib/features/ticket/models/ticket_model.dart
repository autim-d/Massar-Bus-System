class TicketModel {
  final String ticketCode;
  final String date;
  final String time;
  final String passengerName;
  final String passengerPhone;
  final String passengerEmail;
  final double ticketPrice;
  final double protectionFee;
  final double serviceFee;
  final double totalPrice;

  TicketModel({
    required this.ticketCode,
    required this.date,
    required this.time,
    required this.passengerName,
    required this.passengerPhone,
    required this.passengerEmail,
    required this.ticketPrice,
    required this.protectionFee,
    required this.serviceFee,
    required this.totalPrice,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketCode: json['ticket_code'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      passengerName: json['passenger_name'] ?? '',
      passengerPhone: json['passenger_phone'] ?? '',
      passengerEmail: json['passenger_email'] ?? '',
      ticketPrice: (json['ticket_price'] ?? 0).toDouble(),
      protectionFee: (json['protection_fee'] ?? 0).toDouble(),
      serviceFee: (json['service_fee'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
    );
  }
}



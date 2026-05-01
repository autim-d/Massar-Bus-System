import 'package:equatable/equatable.dart';

enum TicketState {
  pendingPayment,
  active,
  completed,
  cancelled,
}

class TicketStatusModel extends Equatable {
  final String id;
  final String date;
  final TicketState state;
  final String from;
  final String to;
  final String busName;
  final String ticketNumber;
  final String seatCount;
  final String departureTime;
  final String arrivalTime;
  final String price;
  final List<String> tags;
  final DateTime? paymentDeadline;

  const TicketStatusModel({
    required this.id,
    required this.date,
    required this.state,
    required this.from,
    required this.to,
    required this.busName,
    required this.ticketNumber,
    required this.seatCount,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    this.tags = const [],
    this.paymentDeadline,
  });

  factory TicketStatusModel.fromJson(Map<String, dynamic> json) {
    final trip = json['trip'] ?? {};
    final pricing = json['pricing'] ?? {};

    TicketState state = TicketState.active;
    final status = json['status']?.toString().toLowerCase();
    if (status == 'pending') {
      state = TicketState.pendingPayment;
    } else if (status == 'completed' || status == 'confirmed') {
      state = TicketState.active;
    } else if (status == 'cancelled') {
      state = TicketState.cancelled;
    }

    return TicketStatusModel(
      id: json['id']?.toString() ?? '',
      date: trip['date'] ?? '---',
      state: state,
      from: trip['fromStation']?['name'] ?? '---',
      to: trip['toStation']?['name'] ?? '---',
      busName: trip['busName'] ?? 'باص مسار',
      ticketNumber: json['booking_code'] ?? 'N/A',
      seatCount: 'مقعد واحد', // يمكن تحديثه لاحقاً
      departureTime: trip['departureTime'] ?? '--:--',
      arrivalTime: trip['arrivalTime'] ?? '--:--',
      price: '${pricing['total_amount'] ?? 0} ر.ي',
      tags: const [], // يمكن استخراجها من نوع الرحلة
      paymentDeadline: json['status'] == 'pending'
          ? DateTime.now().add(const Duration(hours: 2))
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        state,
        from,
        to,
        busName,
        ticketNumber,
        seatCount,
        departureTime,
        arrivalTime,
        price,
        tags,
        paymentDeadline,
      ];
}

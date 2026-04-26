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

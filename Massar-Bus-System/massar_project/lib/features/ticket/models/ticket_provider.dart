import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ticket_model.dart';

// A dummy provider simulating an API call output.
final ticketProvider = Provider<TicketModel>((ref) {
  return TicketModel(
    ticketCode: 'BUS01150224',
    date: 'الاثنين، 19 فبراير 2024',
    time: '15:30',
    passengerName: 'عدنان البيتي',
    passengerPhone: '+967774393235',
    passengerEmail: 'dnanalbyty8@gmail.com',
    ticketPrice: 10.000,
    protectionFee: 10.000,
    serviceFee: 5.000,
    totalPrice: 25.000,
  );
});

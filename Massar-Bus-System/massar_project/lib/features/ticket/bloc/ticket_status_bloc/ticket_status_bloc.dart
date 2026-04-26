import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticket_status_event.dart';
import 'ticket_status_state.dart';
import '../../models/ticket_status_model.dart';

export 'ticket_status_event.dart';
export 'ticket_status_state.dart';

class TicketStatusBloc extends Bloc<TicketStatusEvent, TicketStatusState> {
  TicketStatusBloc() : super(TicketStatusInitial()) {
    on<LoadTicketStatuses>(_onLoadTicketStatuses);
    on<FilterTicketsRequested>(_onFilterTicketsRequested);
  }

  void _onLoadTicketStatuses(
    LoadTicketStatuses event,
    Emitter<TicketStatusState> emit,
  ) async {
    emit(TicketStatusLoading());
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final mockTickets = [
      TicketStatusModel(
        id: '1',
        date: 'أكتوبر 20، 2024',
        state: TicketState.pendingPayment,
        from: 'مدينة المكلا - حضرموت',
        to: 'المهرة',
        busName: 'البراق',
        ticketNumber: '11162',
        seatCount: 'مقعادين',
        departureTime: '10:00 صباحاً',
        arrivalTime: '2:00 مساءاً',
        price: '40,000 ر.ي',
        tags: const ['الاسرع', 'VIP'],
        paymentDeadline: DateTime.now().add(const Duration(minutes: 24, seconds: 40)),
      ),
      const TicketStatusModel(
        id: '2',
        date: 'أكتوبر 15، 2024',
        state: TicketState.active,
        from: 'صنعاء',
        to: 'عدن',
        busName: 'النقل الجماعي',
        ticketNumber: '12882',
        seatCount: 'مقعد واحد',
        departureTime: '8:00 صباحاً',
        arrivalTime: '4:00 مساءاً',
        price: '25,000 ر.ي',
        tags: ['مكيف', 'عائلي'],
      ),
      const TicketStatusModel(
        id: '3',
        date: 'سبتمبر 30، 2024',
        state: TicketState.completed,
        from: 'تعز',
        to: 'إب',
        busName: 'الراحة',
        ticketNumber: '99281',
        seatCount: '3 مقاعد',
        departureTime: '1:00 مساءاً',
        arrivalTime: '3:30 مساءاً',
        price: '15,000 ر.ي',
        tags: [],
      ),
    ];

    emit(TicketStatusLoaded(
      allTickets: mockTickets,
      filteredTickets: mockTickets,
      activeFilter: 'جميع الحالات',
    ));
  }

  void _onFilterTicketsRequested(
    FilterTicketsRequested event,
    Emitter<TicketStatusState> emit,
  ) {
    final currentState = state;
    if (currentState is TicketStatusLoaded) {
      List<TicketStatusModel> filtered;
      if (event.filter == 'جميع الحالات') {
        filtered = currentState.allTickets;
      } else if (event.filter == 'بأنتظار الدفع') {
        filtered = currentState.allTickets
            .where((t) => t.state == TicketState.pendingPayment)
            .toList();
      } else if (event.filter == 'النشطة') {
        filtered = currentState.allTickets
            .where((t) => t.state == TicketState.active)
            .toList();
      } else if (event.filter == 'المكتملة') {
        filtered = currentState.allTickets
            .where((t) => t.state == TicketState.completed)
            .toList();
      } else {
        filtered = currentState.allTickets;
      }

      emit(TicketStatusLoaded(
        allTickets: currentState.allTickets,
        filteredTickets: filtered,
        activeFilter: event.filter,
      ));
    }
  }
}

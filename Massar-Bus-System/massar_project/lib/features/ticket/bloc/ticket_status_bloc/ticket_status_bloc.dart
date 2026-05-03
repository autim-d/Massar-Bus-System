import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticket_status_event.dart';
import 'ticket_status_state.dart';
import '../../models/ticket_status_model.dart';
import 'package:massar_project/core/repositories/booking_repository.dart';

export 'ticket_status_event.dart';
export 'ticket_status_state.dart';

class TicketStatusBloc extends Bloc<TicketStatusEvent, TicketStatusState> {
  final BookingRepository _bookingRepository;

  TicketStatusBloc(this._bookingRepository) : super(TicketStatusInitial()) {
    on<LoadTicketStatuses>(_onLoadTicketStatuses);
    on<FilterTicketsRequested>(_onFilterTicketsRequested);
  }

  void _onLoadTicketStatuses(
    LoadTicketStatuses event,
    Emitter<TicketStatusState> emit,
  ) async {
    emit(TicketStatusLoading());
    
    try {
      final bookingsJson = await _bookingRepository.getBookings();
      final List<TicketStatusModel> tickets = bookingsJson.map((json) => TicketStatusModel.fromJson(json)).toList();

      emit(TicketStatusLoaded(
        allTickets: tickets,
        filteredTickets: tickets,
        activeFilter: 'جميع الحالات',
      ));
    } catch (e) {
      emit(const TicketStatusLoaded(
        allTickets: [],
        filteredTickets: [],
        activeFilter: 'جميع الحالات',
      ));
    }
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


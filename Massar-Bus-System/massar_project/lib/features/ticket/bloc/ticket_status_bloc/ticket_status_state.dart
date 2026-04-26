import 'package:equatable/equatable.dart';
import '../../models/ticket_status_model.dart';

abstract class TicketStatusState extends Equatable {
  const TicketStatusState();

  @override
  List<Object?> get props => [];
}

class TicketStatusInitial extends TicketStatusState {}

class TicketStatusLoading extends TicketStatusState {}

class TicketStatusLoaded extends TicketStatusState {
  final List<TicketStatusModel> allTickets;
  final List<TicketStatusModel> filteredTickets;
  final String activeFilter;

  const TicketStatusLoaded({
    required this.allTickets,
    required this.filteredTickets,
    required this.activeFilter,
  });

  @override
  List<Object?> get props => [allTickets, filteredTickets, activeFilter];
}

class TicketStatusError extends TicketStatusState {
  final String message;

  const TicketStatusError(this.message);

  @override
  List<Object?> get props => [message];
}

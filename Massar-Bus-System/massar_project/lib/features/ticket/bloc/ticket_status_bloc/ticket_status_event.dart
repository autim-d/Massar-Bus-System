import 'package:equatable/equatable.dart';

abstract class TicketStatusEvent extends Equatable {
  const TicketStatusEvent();

  @override
  List<Object?> get props => [];
}

class LoadTicketStatuses extends TicketStatusEvent {}

class FilterTicketsRequested extends TicketStatusEvent {
  final String filter;

  const FilterTicketsRequested(this.filter);

  @override
  List<Object?> get props => [filter];
}

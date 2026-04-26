import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/checkout_session_model.dart';
import 'package:equatable/equatable.dart';

// --- Events ---
abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
  
  @override
  List<Object?> get props => [];
}

class ProcessPaymentRequested extends CheckoutEvent {}

class ProcessTemporaryBookingRequested extends CheckoutEvent {}

// --- States ---
abstract class CheckoutState extends Equatable {
  const CheckoutState();
  
  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final CheckoutSessionModel session;
  final bool isTemporaryBooking;

  const CheckoutSuccess({required this.session, this.isTemporaryBooking = false});

  @override
  List<Object?> get props => [session, isTemporaryBooking];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}

// --- BLoC ---
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<ProcessPaymentRequested>(_onProcessPayment);
    on<ProcessTemporaryBookingRequested>(_onProcessTemporaryBooking);
  }

  Future<void> _onProcessPayment(
    ProcessPaymentRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(CheckoutLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final session = CheckoutSessionModel(
      orderId: '1502241552',
      paymentMethod: 'Mandiri VA',
      transactionDate: DateTime.now(),
    );
    
    emit(CheckoutSuccess(session: session, isTemporaryBooking: false));
  }

  Future<void> _onProcessTemporaryBooking(
    ProcessTemporaryBookingRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(CheckoutLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final session = CheckoutSessionModel(
      orderId: '1502241552',
      paymentMethod: 'الدفع لاحقاً', // Pay later
      transactionDate: DateTime.now(),
    );
    
    emit(CheckoutSuccess(session: session, isTemporaryBooking: true));
  }
}

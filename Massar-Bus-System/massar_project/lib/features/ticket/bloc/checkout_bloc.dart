import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/checkout_session_model.dart';
import 'package:equatable/equatable.dart';
import 'package:massar_project/core/repositories/booking_repository.dart';
import 'package:massar_project/core/repositories/payment_repository.dart';

// --- Events ---
abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class ProcessPaymentRequested extends CheckoutEvent {
  final String tripId;
  final String? passengerName;
  final String? passengerPhone;

  const ProcessPaymentRequested({
    required this.tripId,
    this.passengerName,
    this.passengerPhone,
  });

  @override
  List<Object?> get props => [tripId, passengerName, passengerPhone];
}

class ProcessTemporaryBookingRequested extends CheckoutEvent {
  final String tripId;
  final String? passengerName;
  final String? passengerPhone;

  const ProcessTemporaryBookingRequested({
    required this.tripId,
    this.passengerName,
    this.passengerPhone,
  });

  @override
  List<Object?> get props => [tripId, passengerName, passengerPhone];
}

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
  final BookingRepository _bookingRepository;
  final PaymentRepository _paymentRepository;

  CheckoutBloc(this._bookingRepository, this._paymentRepository) : super(CheckoutInitial()) {
    on<ProcessPaymentRequested>(_onProcessPayment);
    on<ProcessTemporaryBookingRequested>(_onProcessTemporaryBooking);
  }

  Future<void> _onProcessPayment(
    ProcessPaymentRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(CheckoutLoading());

    // 1. إنشاء حجز في قاعدة البيانات أولاً
    final bookingResult = await _bookingRepository.createBooking(
      event.tripId,
      passengerName: event.passengerName,
      passengerPhone: event.passengerPhone,
    );
    
    if (!bookingResult['success']) {
      emit(CheckoutError(bookingResult['message']));
      return;
    }

    final bookingId = bookingResult['booking']['id'];
    final bookingCode = bookingResult['booking']['booking_code'];

    // 2. إنشاء نية دفع (Payment Intent)
    final intentResult = await _paymentRepository.createPaymentIntent(bookingId);

    if (!intentResult['success']) {
      emit(CheckoutError(intentResult['message']));
      return;
    }

    // 3. تأكيد الدفع (في تطبيق حقيقي سيتم فتح Stripe UI هنا، لكن هنا سنقوم بالتأكيد مباشرة للمحاكاة)
    final confirmResult = await _paymentRepository.confirmPayment(
      bookingId, 
      intentResult['payment_intent_id'],
    );

    if (confirmResult['success']) {
      final session = CheckoutSessionModel(
        orderId: bookingCode ?? 'N/A',
        paymentMethod: 'بن دول باي',
        transactionDate: DateTime.now(),
        passengerName: event.passengerName,
        passengerPhone: event.passengerPhone,
      );
      emit(CheckoutSuccess(session: session, isTemporaryBooking: false));
    } else {
      emit(CheckoutError(confirmResult['message']));
    }
  }

  Future<void> _onProcessTemporaryBooking(
    ProcessTemporaryBookingRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(CheckoutLoading());

    final result = await _bookingRepository.createBooking(
      event.tripId,
      passengerName: event.passengerName,
      passengerPhone: event.passengerPhone,
    );

    if (result['success']) {
      final booking = result['booking'];
      final session = CheckoutSessionModel(
        orderId: booking['booking_code'] ?? 'N/A',
        paymentMethod: 'حجز مؤقت',
        transactionDate: DateTime.now(),
        passengerName: event.passengerName,
        passengerPhone: event.passengerPhone,
      );
      emit(CheckoutSuccess(session: session, isTemporaryBooking: true));
    } else {
      emit(CheckoutError(result['message']));
    }
  }
}

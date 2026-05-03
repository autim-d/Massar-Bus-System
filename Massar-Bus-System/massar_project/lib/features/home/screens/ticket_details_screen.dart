import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/bus_ticket_model.dart';
import '../widgets/components/detailed_ticket_card.dart';
import '../widgets/components/map_placeholder_card.dart';
import '../widgets/components/passenger_info_card.dart';
import '../widgets/components/protection_promo_banner.dart';
import 'package:massar_project/core/widgets/guest_action_interceptor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/features/ticket/bloc/checkout_bloc.dart';
import 'package:massar_project/features/ticket/widgets/components/animated_success_modal.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';

class TicketDetailsScreen extends StatefulWidget {
  final BusTicketModel ticket;

  const TicketDetailsScreen({
    super.key,
    required this.ticket,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  late String? passengerName;
  late String? passengerPhone;

  @override
  void initState() {
    super.initState();
    passengerName = widget.ticket.passengerName;
    passengerPhone = widget.ticket.passengerPhone;
  }

  @override
  Widget build(BuildContext context) {
    
    

    // Determine a dynamic convenience fee based on ticket price (e.g. 5%)
    final double convenienceFee = widget.ticket.price * 0.05;
    final double totalPrice = widget.ticket.price + convenienceFee;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'تذكرة اختيارك',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'ReadexPro',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
            onPressed: () => context.pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.grey200,
              height: 1.0,
            ),
          ),
        ),
        body: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccess) {
              showAnimatedSuccessModal(
                context: context,
                title: "تم الحجز بنجاح",
                orderId: state.session.orderId,
                paymentMethod: state.session.paymentMethod,
                transactionDate: state.session.transactionDate,
                onViewTicket: () {
                  if (state.isTemporaryBooking) {
                    // تحديث بيانات المستخدم (عدد الإشعارات) فوراً بعد الحجز الناجح
                    context.read<AuthBloc>().add(GetUserDataEvent());
                    
                    context.go('/tickets/my-ticket', extra: state.session);
                  }
                },
              );
            } else if (state is CheckoutError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section 1: Detailed Ticket Card
                DetailedTicketCard(ticket: widget.ticket),
                const SizedBox(height: 32),

                // Section 2: Map Tracking
                const MapPlaceholderCard(),
                const SizedBox(height: 32),

                // Section 3: Passenger Info
                PassengerInfoCard(
                  initialName: passengerName,
                  initialPhone: passengerPhone,
                  onChanged: (name, phone) {
                    setState(() {
                      passengerName = name;
                      passengerPhone = phone;
                    });
                  },
                ),
                const SizedBox(height: 32),

                // Section 4: Promo Banner
                const ProtectionPromoBanner(),
                const SizedBox(height: 32),

                // Pricing Details
                Text(
                  'تفاصيل الدفع',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: 'ReadexPro',
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سعر التذكرة',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                    Text(
                      '${widget.ticket.price.toInt()} ريال يمني',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'رسوم الراحه',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                    Text(
                      '${convenienceFee.toInt()} ريال يمني',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                    Text(
                      '${totalPrice.toInt()} ريال يمني',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainButton,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Action Buttons
                GuestActionInterceptor(
                    onTap: () {
                      // Navigate to Payment Method
                      context.push('/tickets/payment', 
                        extra: widget.ticket.copyWith(
                          passengerName: passengerName,
                          passengerPhone: passengerPhone,
                        )
                      );
                    },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.mainButton,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'اختيار طريقه الدفع',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ReadexPro',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                GuestActionInterceptor(
                  onTap: () {
                    // Handle temporary booking via BLoC
                    context.read<CheckoutBloc>().add(
                          ProcessTemporaryBookingRequested(
                            tripId: widget.ticket.id,
                            passengerName: passengerName,
                            passengerPhone: passengerPhone,
                          ),
                        );
                  },
                  child: BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      final isLoading = state is CheckoutLoading;
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.mainButton),
                        ),
                        alignment: Alignment.center,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text(
                                'حجز مؤقت',
                                style: TextStyle(
                                  color: AppColors.mainButton,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ReadexPro',
                                  fontSize: 16,
                                ),
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}








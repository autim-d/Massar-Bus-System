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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine a sample convenience fee based on ticket price (e.g. fixed 200)
    const double convenienceFee = 200.0;
    final double totalPrice = widget.ticket.price + convenienceFee;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'تذكرة اختيارك',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'ReadexPro',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color, size: 20),
            onPressed: () => context.pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: theme.dividerColor,
              height: 1.0,
            ),
          ),
        ),
        body: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccess && state.isTemporaryBooking) {
              showAnimatedSuccessModal(
                context: context,
                title: "تم الحجز بنجاح",
                orderId: state.session.orderId,
                paymentMethod: state.session.paymentMethod,
                transactionDate: state.session.transactionDate,
                onViewTicket: () {
                  context.go('/tickets/my-ticket', extra: state.session);
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
                    color: theme.textTheme.titleLarge?.color,
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
                        color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                    Text(
                      '${widget.ticket.price.toInt()} ريال يمني',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.textTheme.bodyLarge?.color,
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
                        color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                    Text(
                      '${convenienceFee.toInt()} ريال يمني',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.textTheme.bodyLarge?.color,
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
                        color: theme.textTheme.titleLarge?.color,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                    Text(
                      '${totalPrice.toInt()} ريال يمني',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1570EF),
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
                    context.push('/tickets/payment', extra: widget.ticket);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1570EF),
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
                          color: theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF1570EF)),
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
                                  color: Color(0xFF1570EF),
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

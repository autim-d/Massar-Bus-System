import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_provider.dart';
import '../widgets/qr_code_section.dart';
import '../widgets/passenger_details_card.dart';
import '../widgets/payment_summary_card.dart';

class DetailTicketScreen extends ConsumerWidget {
  const DetailTicketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the ticket data from our Riverpod provider
    final ticket = ref.watch(ticketProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // إذا لم تكن هناك تذكرة محددة بعد
    if (ticket == null) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('تذكرتك'),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: const Center(
            child: Text('لا توجد تذكرة محددة', style: TextStyle(fontSize: 16)),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('تذكرتك'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QrCodeSection(
                        ticketCode: ticket.ticketCode,
                        date: ticket.date,
                      ),
                      
                      // NOTE: Add RouteSummaryCard internally here
                      const SizedBox(height: 20),

                      PassengerDetailsCard(
                        name: ticket.passengerName,
                        email: ticket.passengerEmail,
                        phone: ticket.passengerPhone,
                      ),

                      const SizedBox(height: 20),
                      Container(height: 8, color: Colors.grey[300]),
                      const SizedBox(height: 20),

                      PaymentSummarySection(
                        ticketPrice: ticket.ticketPrice,
                        protectionFee: ticket.protectionFee,
                        serviceFee: ticket.serviceFee,
                        totalPrice: ticket.totalPrice,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


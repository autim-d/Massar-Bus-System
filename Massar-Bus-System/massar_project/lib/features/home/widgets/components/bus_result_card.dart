import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/bus_ticket_model.dart';
import 'tag_chip.dart';
import 'route_timeline.dart';

class BusResultCard extends StatelessWidget {
  final BusTicketModel ticket;
  final String? passengerName;
  final String? passengerPhone;

  const BusResultCard({
    Key? key,
    required this.ticket,
    this.passengerName,
    this.passengerPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    

    return GestureDetector(
      onTap: () {
        context.push('/home/ticket-details', 
          extra: ticket.copyWith(
            passengerName: passengerName,
            passengerPhone: passengerPhone,
          )
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
              color: const Color(0xFFE4E7EC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tags
            Row(
              children: [
                if (ticket.isFastest) ...[
                  TagChip.fastest(),
                  const SizedBox(width: 8),
                ],
                if (ticket.isCheapest) ...[
                  TagChip.cheapest(),
                  const SizedBox(width: 8),
                ],
                if (ticket.isMenOnly) ...[
                  TagChip.menOnly(),
                  const SizedBox(width: 8),
                ],
                if (ticket.isLadiesOnly) ...[
                  TagChip.ladiesOnly(),
                  const SizedBox(width: 8),
                ],
                if (ticket.isMixed) ...[
                  TagChip.mixed(),
                  const SizedBox(width: 8),
                ],
              ],
            ),
            const SizedBox(height: 20),

            // Route Timeline
            RouteTimeline(
              fromStation: ticket.fromStation,
              toStation: ticket.toStation,
              durationText: ticket.durationText,
            ),
            const SizedBox(height: 24),

            // Bus Details & Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_bus_rounded,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.busName,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'وصول في ${ticket.arrivalTime}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${ticket.price.toInt()} ر.ي',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE85C0D), // Orange price
                      ),
                    ),
                    Text(
                      '/مسافر',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Buy Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.mainButton,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                'شراء',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ReadexPro',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





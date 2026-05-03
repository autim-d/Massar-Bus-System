import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../models/bus_ticket_model.dart';
import 'tag_chip.dart';
import 'vertical_route_timeline.dart';
String _formatArabicDate(DateTime date) {
  const weekdays = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
  const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
  
  final weekday = weekdays[date.weekday - 1];
  final month = months[date.month - 1];
  
  return '$weekday , ${date.day} $month , ${date.year}';
}

class DetailedTicketCard extends StatelessWidget {
  final BusTicketModel ticket;

  const DetailedTicketCard({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    
    

    // Basic Arabic date formatting
    final dateString = _formatArabicDate(ticket.date);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFFE4E7EC),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  dateString,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: 'ReadexPro',
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Middle Row: Bus Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.directions_bus_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ticket.busName,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ReadexPro',
                    ),
                  ),
                ],
              ),
              Text(
                'الوصول في ${ticket.arrivalTime} الى ${ticket.toStation.name}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontFamily: 'ReadexPro',
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tags
          Row(
            children: [
              if (ticket.isFastest) ...[
                TagChip.fastest(),
                const SizedBox(width: 8),
              ],
              if (ticket.isMixed) ...[
                TagChip.mixed(),
                const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 24),

          // Dashed Divider
          Divider(
            color: AppColors.grey200,
            height: 1,
          ),
          const SizedBox(height: 24),

          // Vertical Timeline
          VerticalRouteTimeline(
            fromStation: ticket.fromStation.name,
            toStation: ticket.toStation.name,
            dateString: dateString,
          ),
        ],
      ),
    );
  }
}







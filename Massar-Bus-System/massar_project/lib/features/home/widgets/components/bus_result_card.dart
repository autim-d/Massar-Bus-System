import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/bus_ticket_model.dart';
import 'tag_chip.dart';
import 'route_timeline.dart';

class BusResultCard extends StatelessWidget {
  final BusTicketModel ticket;

  const BusResultCard({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        context.push('/home/ticket-details', extra: ticket);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : const Color(0xFFE4E7EC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
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
                      color: theme.textTheme.bodyMedium?.color,
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
                            color: theme.textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Arrival in ${ticket.arrivalTime}',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.textTheme.bodyMedium?.color,
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
                      'IDR ${ticket.price.toInt()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE85C0D), // Orange price
                      ),
                    ),
                    Text(
                      '/pax',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.textTheme.bodyMedium?.color,
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
                color: const Color(0xFF1570EF),
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

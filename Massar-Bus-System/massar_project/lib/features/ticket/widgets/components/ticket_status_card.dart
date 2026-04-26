import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/ticket_status_model.dart';
import 'countdown_timer_button.dart';

class TicketStatusCard extends StatelessWidget {
  final TicketStatusModel ticket;

  const TicketStatusCard({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (ticket.state) {
      case TicketState.pendingPayment:
        return const Color(0xFFD92D20); // Red
      case TicketState.active:
        return const Color(0xFF1570EF); // Blue
      case TicketState.completed:
        return const Color(0xFF027A48); // Green
      case TicketState.cancelled:
        return const Color(0xFF667085); // Grey
    }
  }

  String _getStatusText() {
    switch (ticket.state) {
      case TicketState.pendingPayment:
        return 'بأنتظار الدفع';
      case TicketState.active:
        return 'النشطة';
      case TicketState.completed:
        return 'المكتملة';
      case TicketState.cancelled:
        return 'ملغاة';
    }
  }

  Widget _buildStatusBadge() {
    final color = _getStatusColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getStatusText(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFFE4E7EC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Date and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.date,
                style: TextStyle(
                  color: isDark ? theme.textTheme.bodySmall?.color : theme.textTheme.bodyMedium?.color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _buildStatusBadge(),
            ],
          ),
          const SizedBox(height: 16),

          // Route and Tags Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tags
              if (ticket.tags.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ticket.tags
                      .map((tag) => Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : const Color(0xFFF2F4F7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? theme.textTheme.bodySmall?.color : theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              if (ticket.tags.isNotEmpty) const SizedBox(width: 16),

              // Timeline Route
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ticket.departureTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: theme.textTheme.bodyLarge?.color),
                        ),
                        const Icon(Icons.directions_bus,
                            color: Color(0xFF1570EF), size: 18),
                        Text(
                          ticket.arrivalTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: theme.textTheme.bodyLarge?.color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                            child: Text(ticket.from,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: isDark ? theme.textTheme.bodySmall?.color : theme.textTheme.bodyMedium?.color,
                                    fontSize: 12))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.arrow_forward_ios,
                              size: 10,
                              color: isDark
                                  ? Colors.white.withOpacity(0.3)
                                  : const Color(0xFFD0D5DD)),
                        ),
                        Expanded(
                            child: Text(ticket.to,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: isDark ? theme.textTheme.bodySmall?.color : theme.textTheme.bodyMedium?.color,
                                    fontSize: 12))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
              color: theme.dividerColor),
          const SizedBox(height: 12),

          // Bus info and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.busName,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyLarge?.color,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'رقم التذكرة: ${ticket.ticketNumber} · ${ticket.seatCount}',
                    style: TextStyle(
                        color: isDark ? theme.textTheme.bodySmall?.color : theme.textTheme.bodyMedium?.color, fontSize: 12),
                  ),
                ],
              ),
              Text(
                ticket.price,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF1570EF),
                ),
              ),
            ],
          ),

          // Actions for pending payment
          if (ticket.state == TicketState.pendingPayment && ticket.paymentDeadline != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CountdownTimerButton(
                    deadline: ticket.paymentDeadline!,
                    onTimeExpired: () {
                      // Handled in bloc or locally if needed
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // In a real app this would route to payment screen
                      // context.push('/tickets/payment', extra: ticket);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1570EF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'الدفع',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
  }


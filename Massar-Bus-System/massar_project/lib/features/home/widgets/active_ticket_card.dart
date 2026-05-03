import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/features/home/providers/active_ticket_provider.dart';
import 'package:massar_project/features/home/widgets/e_ticket_modal.dart';

class ActiveTicketCard extends ConsumerWidget {
  const ActiveTicketCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeTicketAsync = ref.watch(activeTicketProvider);

    return activeTicketAsync.when(
      data: (ticket) {
        if (ticket == null) return _buildNoTicketPlaceholder(theme, isDark);

        final String bookingCode = ticket['booking_code'];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'تذكرتك النشطة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 16),
              Container(
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
                    // Date
                    Text(
                      ticket['date'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tags
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE85C0D), // Orange
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            'الأسرع',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1D2939) : Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : const Color(0xFFE4E7EC)),
                          ),
                          child: Text(
                            'مختلط',
                            style: TextStyle(
                              color: theme.textTheme.bodyMedium?.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Timeline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Origin Station
                        _buildStationInfo(
                          context,
                          iconColor: const Color(0xFF12B76A), // Green
                          title: 'محطة',
                          subtitle: ticket['from'],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),

                        // Duration Connector
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1.5,
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : const Color(0xFFF2F4F7),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1D2939)
                                        : const Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                        color: isDark
                                            ? Colors.white.withValues(alpha: 0.1)
                                            : const Color(0xFFE4E7EC)),
                                  ),
                                  child: Text(
                                    'المدة: ${ticket['duration']}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: theme.textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1.5,
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : const Color(0xFFF2F4F7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Destination Station
                        _buildStationInfo(
                          context,
                          iconColor: const Color(0xFFE85C0D), // Orange
                          title: 'محطة',
                          subtitle: ticket['to'],
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Bus Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.directions_bus_rounded,
                          color: theme.textTheme.bodyMedium?.color,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            ticket['bus_info'],
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.textTheme.bodyMedium?.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // See Barcode Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          ETicketModal.show(context, bookingCode: bookingCode);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1570EF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'عرض الباركود',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => _buildNoTicketPlaceholder(theme, isDark),
    );
  }

  Widget _buildStationInfo(
    BuildContext context, {
    required Color iconColor,
    required String title,
    required String subtitle,
    required CrossAxisAlignment crossAxisAlignment,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (crossAxisAlignment == CrossAxisAlignment.start) ...[
          _buildMarkerIcon(iconColor),
          const SizedBox(width: 8),
        ],
        Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (crossAxisAlignment == CrossAxisAlignment.end) ...[
          const SizedBox(width: 8),
          _buildMarkerIcon(iconColor),
        ],
      ],
    );
  }

  Widget _buildMarkerIcon(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildNoTicketPlaceholder(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : const Color(0xFFE4E7EC)),
        ),
        child: Column(
          children: [
            Icon(Icons.confirmation_number_outlined, 
                 size: 48, 
                 color: theme.disabledColor.withValues(alpha: 0.3)),
            const SizedBox(height: 12),
            Text(
              'لا توجد تذاكر نشطة حالياً',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

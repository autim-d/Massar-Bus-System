import 'package:flutter/material.dart';
import 'package:massar_project/features/home/widgets/e_ticket_modal.dart';

class ActiveTicketCard extends StatelessWidget {
  const ActiveTicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const String bookingCode = 'BUS01150224';

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
                      ? Colors.white.withOpacity(0.1)
                      : const Color(0xFFE4E7EC)),
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
                // Date
                Text(
                  'Mon, 19 February 2024',
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
                                ? Colors.white.withOpacity(0.1)
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
                    // Start Station
                    _buildStationInfo(
                      context,
                      iconColor: const Color(0xFF12B76A), // Green
                      title: 'محطة',
                      subtitle: 'K. Bali',
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
                                    ? Colors.white.withOpacity(0.1)
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
                                        ? Colors.white.withOpacity(0.1)
                                        : const Color(0xFFE4E7EC)),
                              ),
                              child: Text(
                                'المدة: 30 دقيقة',
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
                                    ? Colors.white.withOpacity(0.1)
                                    : const Color(0xFFF2F4F7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // End Station
                    _buildStationInfo(
                      context,
                      iconColor: const Color(0xFFE85C0D), // Orange
                      title: 'محطة',
                      subtitle: 'Senen',
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
                        'باص 01   الوصول الساعة 15:30 في المحطة',
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
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
    );
  }
}

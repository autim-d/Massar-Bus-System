import 'package:flutter/material.dart';

class LocationInputConnector extends StatelessWidget {
  final TextEditingController originController;
  final TextEditingController destinationController;
  final Function(String) onDestinationSubmitted;

  const LocationInputConnector({
    Key? key,
    required this.originController,
    required this.destinationController,
    required this.onDestinationSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE4E7EC),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Origin Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: originController,
                    decoration: InputDecoration(
                      hintText: 'موقعك الحالي',
                      hintStyle: TextStyle(
                        color: theme.textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.w600,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xFF12B76A), // Green
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider & Dotted Line
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE4E7EC),
                  margin: const EdgeInsets.only(left: 44),
                ),
              ),
              // Dotted line simulation using small containers
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 2,
                      height: 3,
                      margin: const EdgeInsets.only(bottom: 2),
                      color: isDark ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFD0D5DD),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Destination Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: destinationController,
                    onSubmitted: onDestinationSubmitted,
                    decoration: InputDecoration(
                      hintText: 'البحث عن وجهة',
                      hintStyle: TextStyle(
                        color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE85C0D), // Orange
                      width: 4,
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
}

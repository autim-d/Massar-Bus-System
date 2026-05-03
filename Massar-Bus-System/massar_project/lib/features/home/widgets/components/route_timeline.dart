import 'package:flutter/material.dart';
import '../../models/location_model.dart';

class RouteTimeline extends StatelessWidget {
  final LocationModel fromStation;
  final LocationModel toStation;
  final String durationText;

  const RouteTimeline({
    Key? key,
    required this.fromStation,
    required this.toStation,
    required this.durationText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Start Station
        _buildStationInfo(
          context,
          iconColor: const Color(0xFF12B76A), // Green
          title: fromStation.description ?? 'محطة',
          subtitle: fromStation.name,
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
                    color: theme.dividerColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Text(
                    durationText,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1.5,
                    color: theme.dividerColor,
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
          title: toStation.description ?? 'محطة',
          subtitle: toStation.name,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ],
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
    final isDark = theme.brightness == Brightness.dark;
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
                color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
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
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
    );
  }
}

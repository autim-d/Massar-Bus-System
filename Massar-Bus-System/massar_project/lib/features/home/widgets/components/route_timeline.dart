import 'package:massar_project/core/theme/app_colors.dart';
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
                    color: AppColors.grey200,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: AppColors.grey200),
                  ),
                  child: Text(
                    durationText,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1.5,
                    color: AppColors.grey200,
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
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
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
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
    );
  }
}







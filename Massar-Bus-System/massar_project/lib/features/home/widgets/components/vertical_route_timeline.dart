import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class VerticalRouteTimeline extends StatelessWidget {
  final String fromStation;
  final String toStation;
  final String dateString;

  const VerticalRouteTimeline({
    super.key,
    required this.fromStation,
    required this.toStation,
    required this.dateString,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Start node
        _buildNode(
          context,
          icon: Icons.my_location,
          iconColor: Colors.green,
          title: 'العمل',
          subtitle: 'موقعك',
          durationTag: '10 دقائق',
        ),
        _buildLine(context),
        // Transit node
        _buildNode(
          context,
          icon: Icons.directions_bus,
          iconColor: Colors.green,
          title: 'الوقوف',
          subtitle: fromStation, // Uses actual from station
          durationTag: '30 دقيقة',
        ),
        _buildLine(context),
        // End node
        _buildNode(
          context,
          icon: Icons.location_on,
          iconColor: const Color(0xFFE85C0D), // Orange
          title: 'اليوم',
          subtitle: dateString.split(' ').first, // Use day name
        ),
      ],
    );
  }

  Widget _buildNode(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? durationTag,
  }) {
    
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: iconColor, width: 2),
            color: Colors.white,
          ),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color:  AppColors.textSecondary,
                  fontFamily: 'ReadexPro',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ReadexPro',
                ),
              ),
              if (durationTag != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    durationTag,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                      fontFamily: 'ReadexPro',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLine(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(right: 11, bottom: 4, top: 4), // Align with center of 24px circle
      child: SizedBox(
        height: 24,
        width: 2,
        child: CustomPaint(
          painter: _DashedLinePainter(AppColors.grey200),
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  _DashedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 4, dashSpace = 4, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}







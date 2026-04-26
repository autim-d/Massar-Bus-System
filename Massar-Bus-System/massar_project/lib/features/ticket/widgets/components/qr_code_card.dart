import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QRCodeCard extends StatelessWidget {
  final String orderId;

  const QRCodeCard({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          "تذكرتك الإلكترونية",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 20),

        // QR Code Graphic placeholder (can use qr_flutter package in a real app)
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            border: Border.all(
                color: theme.dividerColor,
                width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/images/qr_placeholder.png', // Fallback
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.qr_code_2,
                  size: 150,
                  color: isDark ? Colors.white70 : Colors.grey.shade800);
            },
          ),
        ),

        const SizedBox(height: 16),

        Text(
          "كود الحجز",
          style: TextStyle(
            fontSize: 12,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          orderId,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),

        const SizedBox(height: 12),
        Text(
          "قم بمسح الرمز الشريطي أو إدخال رمز الحجز عند ركوب الحافلة.",
          style: TextStyle(
            fontSize: 11,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}

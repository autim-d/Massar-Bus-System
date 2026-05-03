import 'package:massar_project/core/theme/app_colors.dart';
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
    
    

    return Column(
      children: [
        Text(
          "تذكرتك الإلكترونية",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),

        // QR Code Graphic placeholder (can use qr_flutter package in a real app)
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: AppColors.grey200,
                width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/images/qr_placeholder.png', // Fallback
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.qr_code_2,
                  size: 150,
                  color: Colors.grey.shade800);
            },
          ),
        ),

        const SizedBox(height: 16),

        Text(
          "كود الحجز",
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          orderId,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 12),
        Text(
          "قم بمسح الرمز الشريطي أو إدخال رمز الحجز عند ركوب الحافلة.",
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}







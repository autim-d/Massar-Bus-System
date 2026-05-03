import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ETicketModal extends StatelessWidget {
  final String bookingCode;

  const ETicketModal({
    Key? key,
    required this.bookingCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensuring RTL support by using Directionality if needed, 
    // but the app is already configured for RTL in main.dart.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with Close Button (Aligned to Left as per design)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Color(0xFF1D2939)),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Title
          const Text(
            'تذكرتك الإلكترونية',
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2939),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // QR Code
          Center(
            child: QrImageView(
              data: bookingCode,
              version: QrVersions.auto,
              size: 240.0,
              gapless: false,
              foregroundColor: const Color(0xFF1D2939),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Booking Code Section
          const Text(
            'كود الحجز',
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            bookingCode,
            style: const TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2939),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Footer Instruction
          const Text(
            'امسح الباركود أو أدخل كود الحجز عند ركوب الباص',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static void show(BuildContext context, {required String bookingCode}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ETicketModal(bookingCode: bookingCode),
    );
  }
}

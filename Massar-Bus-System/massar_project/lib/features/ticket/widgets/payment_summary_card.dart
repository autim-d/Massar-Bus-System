import 'package:flutter/material.dart';

class PaymentSummarySection extends StatelessWidget {
  final double ticketPrice;
  final double protectionFee;
  final double serviceFee;
  final double totalPrice;

  const PaymentSummarySection({
    super.key,
    required this.ticketPrice,
    required this.protectionFee,
    required this.serviceFee,
    required this.totalPrice,
  });

  Widget _priceRow(String title, String amount, {bool bold = false, Color color = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            amount,
            style: TextStyle(
              fontSize: bold ? 18 : 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: bold ? 16 : 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تفاصيل الدفع',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        _priceRow('سعر التذكرة', ticketPrice.toStringAsFixed(3)),
        const Divider(thickness: 1),
        _priceRow('الحماية', protectionFee.toStringAsFixed(3)),
        const Divider(thickness: 1),
        _priceRow('رسوم الخدمة', serviceFee.toStringAsFixed(3)),
        const Divider(thickness: 1),
        _priceRow(
          'الإجمالي',
          totalPrice.toStringAsFixed(3),
          bold: true,
          color: Colors.blue,
        ),
      ],
    );
  }
}

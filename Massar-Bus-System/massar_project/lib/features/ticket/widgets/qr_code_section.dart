import 'package:flutter/material.dart';

class QrCodeSection extends StatelessWidget {
  final String ticketCode;
  final String date;

  const QrCodeSection({
    super.key,
    required this.ticketCode,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تذكرتك الالكترونية',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            'assets/images/qr.png',
            width: 200,
            height: 200,
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text(
            'كود الحجز',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            ticketCode,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'قم بمسح الرمز الشريطي أو إدخال رمز الحجز عند ركوب الحافلة.',
            style: TextStyle(color: Color.fromARGB(255, 170, 165, 165), fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Container(height: 8, color: Colors.grey[300]),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

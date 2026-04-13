import 'package:flutter/material.dart';

class PassengerDetailsCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const PassengerDetailsCard({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'اسم العميل',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(name),
              const SizedBox(height: 3),
              Text(email),
              const SizedBox(height: 4),
              Text(phone),
            ],
          ),
        ),
      ],
    );
  }
}

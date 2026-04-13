import 'package:flutter/material.dart';

class AccountDetailsFormPage extends StatelessWidget {
  const AccountDetailsFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFFE4EAF1)),
    );
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF5F7FB),
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: Color(0xFF0053D9), width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1D1D1D)),
          onPressed: () {},
        ),
        title: const Text(
          'بيانات الحساب',
          style: TextStyle(
            color: Color(0xFF1D1D1D),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'أكمل إدخال بياناتك البنكية',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D1D1D),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'ساعدنا على التعرف عليك بشكل أفضل لضمان تجربة سفر سلسة.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7683),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'الاسم الكامل',
                style: TextStyle(
                  color: Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: inputDecoration.copyWith(
                  hintText: 'أدخل اسمك الرباعي',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'عنوان البريد الإلكتروني',
                style: TextStyle(
                  color: Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration.copyWith(
                  hintText: 'example@email.com',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'رقم الهوية الإماراتية',
                style: TextStyle(
                  color: Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                decoration: inputDecoration.copyWith(
                  hintText: '784-1987-1234567-1',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'الجنسية',
                style: TextStyle(
                  color: Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: inputDecoration,
                value: 'الإمارات العربية المتحدة',
                items: const [
                  DropdownMenuItem(
                    value: 'الإمارات العربية المتحدة',
                    child: Text('الإمارات العربية المتحدة'),
                  ),
                  DropdownMenuItem(
                    value: 'السعودية',
                    child: Text('السعودية'),
                  ),
                  DropdownMenuItem(
                    value: 'الكويت',
                    child: Text('الكويت'),
                  ),
                ],
                onChanged: (_) {},
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0053D9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'حفظ ومتابعة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'سأكمل لاحقًا',
                    style: TextStyle(
                      color: Color(0xFF6B7683),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


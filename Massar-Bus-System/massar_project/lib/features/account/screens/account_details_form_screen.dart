import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AccountDetailsFormScreen extends StatelessWidget {
  const AccountDetailsFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: theme.dividerColor),
    );
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: theme.inputDecorationTheme.fillColor ?? (isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FB)),
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: Color(0xFF0053D9), width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      hintStyle: TextStyle(color: theme.textTheme.bodySmall?.color),
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.iconTheme.color),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'بيانات الحساب',
          style: TextStyle(
            color: theme.textTheme.titleLarge?.color,
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
              Text(
                'أكمل إدخال بياناتك البنكية',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ساعدنا على التعرف عليك بشكل أفضل لضمان تجربة سفر سلسة.',
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF6B7683),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'الاسم الكامل',
                style: TextStyle(
                  color: isDark ? theme.textTheme.bodyLarge?.color : const Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: inputDecoration.copyWith(
                  hintText: 'أدخل اسمك الرباعي',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'عنوان البريد الإلكتروني',
                style: TextStyle(
                  color: isDark ? theme.textTheme.bodyLarge?.color : const Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: inputDecoration.copyWith(
                  hintText: 'example@email.com',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'رقم الهوية الإماراتية',
                style: TextStyle(
                  color: isDark ? theme.textTheme.bodyLarge?.color : const Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: inputDecoration.copyWith(
                  hintText: '784-1987-1234567-1',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'الجنسية',
                style: TextStyle(
                  color: isDark ? theme.textTheme.bodyLarge?.color : const Color(0xFF4C5968),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: inputDecoration,
                dropdownColor: theme.cardTheme.color,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                value: 'الإمارات العربية المتحدة',
                items: [
                  DropdownMenuItem(
                    value: 'الإمارات العربية المتحدة',
                    child: Text('الإمارات العربية المتحدة', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                  ),
                  DropdownMenuItem(
                    value: 'السعودية',
                    child: Text('السعودية', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                  ),
                  DropdownMenuItem(
                    value: 'الكويت',
                    child: Text('الكويت', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                  ),
                ],
                onChanged: (_) {},
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0053D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    // In a real app, logic to save details would go here.
                    // For now, we return to the home branch.
                    context.go('/home');
                  },
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
                  onPressed: () {
                    context.go('/home');
                  },
                  child: Text(
                    'سأكمل لاحقًا',
                    style: TextStyle(
                      color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF6B7683),
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


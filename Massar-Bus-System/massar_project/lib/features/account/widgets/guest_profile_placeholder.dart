import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GuestProfilePlaceholder extends StatelessWidget {
  const GuestProfilePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.userX,
              size: 64,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'يرجى تسجيل الدخول',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'سجل دخولك الآن لتتمكن من عرض ملفك الشخصي وإدارة حجوزاتك وإعدادات حسابك.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 14,
              color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the login screen
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontFamily: 'ReadexPro',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.go('/signup'),
            child: const Text(
              'ليس لديك حساب؟ إنشاء حساب جديد',
              style: TextStyle(
                fontFamily: 'ReadexPro',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2563EB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

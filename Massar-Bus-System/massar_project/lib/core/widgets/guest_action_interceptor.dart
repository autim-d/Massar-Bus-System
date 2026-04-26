import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';

class GuestActionInterceptor extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const GuestActionInterceptor({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final authState = context.read<AuthBloc>().state;
        if (authState is AuthGuest) {
          _showGuestPrompt(context);
        } else {
          onTap();
        }
      },
      child: child,
    );
  }

  void _showGuestPrompt(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.lock_outline_rounded,
                  size: 64,
                  color: Color(0xFFE85C0D), // Brand orange
                ),
                const SizedBox(height: 16),
                const Text(
                  'يجب تسجيل الدخول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2939),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'يجب تسجيل الدخول لإتمام عملية الحجز واستخدام كافة ميزات التطبيق.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    fontSize: 14,
                    color: Color(0xFF667085),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close bottom sheet
                    context.go('/login'); // Navigate to login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close bottom sheet
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'إلغاء',
                    style: TextStyle(
                      fontFamily: 'ReadexPro',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF667085),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

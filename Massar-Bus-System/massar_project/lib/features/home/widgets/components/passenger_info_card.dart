import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';

class PassengerInfoCard extends StatelessWidget {
  const PassengerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الاسم المطلوب',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.titleLarge?.color,
            fontFamily: 'ReadexPro',
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFE4E7EC),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String name = 'زائر';
              String email = '';
              String phone = '';

              if (state is AuthAuthenticated) {
                name = state.name;
                email = state.email;
                // Since AuthAuthenticated currently doesn't store phone, we use a placeholder or read it if available.
                phone = '+967 776463185';
              } else if (state is AuthGuest) {
                name = 'ضيف (زائر)';
                email = 'يرجى تسجيل الدخول للحجز';
                phone = '';
              }

              return Row(
                children: [
                  Icon(
                    LucideIcons.edit2,
                    color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                            fontFamily: 'ReadexPro',
                          ),
                        ),
                        if (email.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                              fontFamily: 'ReadexPro',
                            ),
                          ),
                        ],
                        if (phone.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            phone,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                              fontFamily: 'ReadexPro',
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

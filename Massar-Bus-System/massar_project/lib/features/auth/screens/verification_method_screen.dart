import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

// استيراد الـ Bloc والـ Events/States
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class VerificationMethodScreen extends StatelessWidget {
  final String phoneNumber;

  const VerificationMethodScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final horizontalPadding = w * 0.06;

    // استخدام BlocListener لمراقبة رد السيرفر بعد طلب الإرسال
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSentSuccess) {
          // إذا نجح السيرفر في الإرسال، ننتقل لشاشة إدخال الكود
          context.push('/otp', extra: phoneNumber);
        } else if (state is AuthError) {
          // إظهار خطأ في حال فشل الاتصال بالسيرفر
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // AppBar مخصص خفيف
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back, size: 24),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'طريقة التحقق',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'air',
                              fontSize: w * 0.062,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey.shade900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'إختر طريقة التحقق من المذكورة أدناه',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'air',
                              fontSize: w * 0.036,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // بطاقة واتساب (مربوطة الآن بالباك أند)
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final isLoading = state is AuthLoading;

                              return GestureDetector(
                                onTap: isLoading
                                    ? null
                                    : () {
                                        // إرسال طلب للباك أند لإرسال الرمز عبر واتساب
                                        context.read<AuthBloc>().add(
                                          SendOtpRequested(phone: phoneNumber),
                                        );
                                      },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isLoading
                                        ? Colors.grey.shade100
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF25D366),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: isLoading
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                )
                                              : const Icon(
                                                  Bootstrap.whatsapp,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // تعديل ليتناسب مع RTL بشكل أفضل
                                          children: [
                                            Text(
                                              'واتساب إلى',
                                              style: TextStyle(
                                                fontFamily: 'air',
                                                fontSize: w * 0.038,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              phoneNumber,
                                              style: TextStyle(
                                                fontFamily: 'air',
                                                fontSize: w * 0.034,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




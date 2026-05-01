import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // استخدام BlocConsumer للاستماع للأحداث وبناء الواجهة بناءً على الحالة
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // نجاح تسجيل الدخول: التوجيه للصفحة الرئيسية
          context.go('/home');
        } else if (state is AuthError) {
          // فشل تسجيل الدخول: إظهار رسالة الخطأ القادمة من السيرفر
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(fontFamily: 'Cairo'),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        // التحقق مما إذا كان التطبيق في حالة تحميل حالياً
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // ... [كود الشعار (Logo) ونصوص الترحيب كما هي في كودك] ...
                      Container(
                        width: 220,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.directions_bus,
                              color: Colors.white,
                              size: 48,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'مســار',
                              style: TextStyle(
                                fontFamily: 'AirStrip',
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'مرحباً بكم من جديد',
                        style: TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 14,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        label: 'البريد الإلكتروني',
                        hintText: 'your_email@example.com',
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        enabled: !isLoading, // تعطيل الحقل أثناء التحميل
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'الرجاء إدخال البريد الإلكتروني';
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                          );
                          if (!emailRegex.hasMatch(value))
                            return 'صيغة البريد الإلكتروني غير صالحة';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: _passwordController,
                            label: 'كلمة المرور',
                            hintText: '.........',
                            isObscure: !_isPasswordVisible,
                            textDirection: TextDirection.ltr,
                            enabled: !isLoading, // تعطيل الحقل أثناء التحميل
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'الرجاء إدخال كلمة المرور';
                              if (value.length < 8)
                                return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: theme.textTheme.bodyMedium?.color,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () {}, // تعطيل الزر أثناء التحميل
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'نسيت كلمة المرور؟',
                                style: TextStyle(
                                  fontFamily: 'ReadexPro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1570EF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    FocusScope.of(
                                      context,
                                    ).unfocus(); // إخفاء الكيبورد
                                    context.read<AuthBloc>().add(
                                      LoginSubmitted(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          // تغيير محتوى الزر إلى دائرة تحميل إذا كان يتصل بالسيرفر
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    fontFamily: 'ReadexPro',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ... [باقي الكود الخاص بك (Google Login, Guest Login) كما هو بدون تغيير] ...
                      // [تم اختصاره هنا لتوضيح التعديلات الأساسية]
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

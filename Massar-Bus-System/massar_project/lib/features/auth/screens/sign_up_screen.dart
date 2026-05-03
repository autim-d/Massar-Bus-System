import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استدعاء BLoC

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';

// تأكد من صحة مسارات استدعاء الـ BLoC
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedGender = 'male';
  String _selectedDialCode = '+967';
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    

    // استخدام BlocConsumer للاستماع لحالة السيرفر
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // نجاح التسجيل: التوجيه للصفحة الرئيسية
          context.go('/home');
        } else if (state is AuthError) {
          // فشل التسجيل: إظهار رسالة الخطأ
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
        // التحقق من حالة التحميل لتعطيل الحقول والزر
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: Colors.white,
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
                      const SizedBox(height: 20),
                      // Logo
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
                      const SizedBox(height: 24),
                      Text(
                        'إنشاء حساب جديد',
                        style: TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'يرجى ملء كافة البيانات التالية للبدء',
                        style: TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),

                      CustomTextField(
                        controller: _firstNameController,
                        label: 'الاسم الأول',
                        hintText: 'أحمد',
                        enabled: !isLoading, // تعطيل أثناء التحميل
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'الرجاء إدخال الاسم الأول'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _lastNameController,
                        label: 'الاسم الأخير',
                        hintText: 'باوزير',
                        enabled: !isLoading,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'الرجاء إدخال الاسم الأخير'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _emailController,
                        label: 'الإيميل',
                        hintText: 'ahmad.hatem959@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        enabled: !isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال البريد الإلكتروني';
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return 'صيغة البريد الإلكتروني غير صالحة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Gender Selector
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الجنس',
                            style: TextStyle(
                              fontFamily: 'ReadexPro',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF344054),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _buildGenderButton(
                                  label: 'ذكر',
                                  value: 'male',
                                  icon: Icons.male,
                                  isLoading: isLoading,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildGenderButton(
                                  label: 'أنثى',
                                  value: 'female',
                                  icon: Icons.female,
                                  isLoading: isLoading,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Phone Number
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'رقم الجوال',
                            style: TextStyle(
                              fontFamily: 'ReadexPro',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF344054),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                height: 52,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFD0D5DD),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedDialCode,
                                    onChanged: isLoading
                                        ? null
                                        : (val) => setState(
                                            () => _selectedDialCode = val!,
                                          ),
                                    items: ['+967', '+966', '+20', '+971'].map((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontFamily: 'ReadexPro',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomTextField(
                                  controller: _phoneController,
                                  label: '', // label already above the row
                                  hintText: '777777777',
                                  keyboardType: TextInputType.phone,
                                  textDirection: TextDirection.ltr,
                                  enabled: !isLoading,
                                  validator: (value) =>
                                      (value == null || value.isEmpty)
                                      ? 'الرجاء إدخال رقم الجوال'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _passwordController,
                        label: 'كلمة المرور',
                        hintText: '.........',
                        isObscure: !_isPasswordVisible,
                        textDirection: TextDirection.ltr,
                        enabled: !isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          if (value.length < 8) {
                            return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

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

                                    final fullPhone =
                                        '$_selectedDialCode${_phoneController.text.trim()}';

                                    // إرسال البيانات للـ BLoC لإنشاء الحساب
                                    context.read<AuthBloc>().add(
                                      RegisterSubmitted(
                                        firstName: _firstNameController.text
                                            .trim(),
                                        lastName: _lastNameController.text
                                            .trim(),
                                        email: _emailController.text.trim(),
                                        phone: fullPhone,
                                        gender: _selectedGender,
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
                                  'إنشاء الحساب',
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

                      // Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لديك حساب سابق؟ ',
                            style: TextStyle(
                              fontFamily: 'ReadexPro',
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: isLoading ? null : () => context.pop(),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontFamily: 'ReadexPro',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainButton,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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

  // تمرير حالة التحميل لمنع الضغط أثناء إرسال الطلب
  Widget _buildGenderButton({
    required String label,
    required String value,
    required IconData icon,
    required bool isLoading,
  }) {
    
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: isLoading ? null : () => setState(() => _selectedGender = value),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFFD0D5DD),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? Colors.white
                  : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'ReadexPro',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}








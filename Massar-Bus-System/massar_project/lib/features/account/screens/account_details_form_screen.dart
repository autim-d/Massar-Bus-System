import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import '../models/user_model.dart';

class AccountDetailsFormScreen extends StatefulWidget {
  const AccountDetailsFormScreen({super.key});

  @override
  State<AccountDetailsFormScreen> createState() =>
      _AccountDetailsFormScreenState();
}

class _AccountDetailsFormScreenState extends State<AccountDetailsFormScreen> {
  // تعريف المتحكمات للحقول
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  String _selectedNationality = 'الإمارات العربية المتحدة';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: AppColors.grey200),
    );

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: Color(0xFF0053D9), width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      hintStyle: TextStyle(color: AppColors.textSecondary),
    );

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          // إظهار رسالة نجاح عند استلام حالة النجاح من الباك اند
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تحديث البيانات بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          context.go('/home');
        } else if (state is AuthError) {
          // إظهار رسالة خطأ في حال فشل الاتصال أو وجود خطأ من السيرفر
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'بيانات الحساب',
              style: TextStyle(
                color: AppColors.textPrimary,
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
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ساعدنا على التعرف عليك بشكل أفضل لضمان تجربة سفر سلسة.',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // الاسم الكامل
                  _buildLabel('الاسم الكامل'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    enabled: !isLoading,
                    style: TextStyle(color: AppColors.textPrimary),
                    decoration: inputDecoration.copyWith(
                      hintText: 'أدخل اسمك الرباعي',
                    ),
                  ),

                  const SizedBox(height: 20),

                  // البريد الإلكتروني
                  _buildLabel('عنوان البريد الإلكتروني'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: AppColors.textPrimary),
                    decoration: inputDecoration.copyWith(
                      hintText: 'example@email.com',
                    ),
                  ),

                  const SizedBox(height: 20),

                  // رقم الهوية
                  _buildLabel('رقم الهوية الإماراتية'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _idController,
                    enabled: !isLoading,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: AppColors.textPrimary),
                    decoration: inputDecoration.copyWith(
                      hintText: '784-1987-1234567-1',
                    ),
                  ),

                  const SizedBox(height: 20),

                  // الجنسية
                  _buildLabel('الجنسية'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: inputDecoration,
                    dropdownColor: Colors.white,
                    style: TextStyle(color: AppColors.textPrimary),
                    value: _selectedNationality,
                    items:
                        [
                          'الإمارات العربية المتحدة',
                          'السعودية',
                          'الكويت',
                          'اليمن',
                        ].map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: isLoading
                        ? null
                        : (val) => setState(() => _selectedNationality = val!),
                  ),

                  const SizedBox(height: 32),

                  // زر حفظ ومتابعة
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
                      onPressed: isLoading ? null : _onSaveProfile,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
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
                      onPressed: isLoading ? null : () => context.go('/home'),
                      child: Text(
                        'سأكمل لاحقًا',
                        style: TextStyle(
                          color: AppColors.textSecondary,
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
      },
    );
  }

  // دالة المساعدة لتسمية الحقول
  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: const Color(0xFF4C5968),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // دالة تجميع البيانات وإرسالها للـ Bloc
  void _onSaveProfile() {
    // التحقق من صحة البيانات (بسيط)
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى ملء الاسم والبريد الإلكتروني'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final updatedUser = UserModel(
      firstName: _nameController.text.split(' ').first,
      lastName: _nameController.text.contains(' ')
          ? _nameController.text.split(' ').last
          : '',
      email: _emailController.text.trim(),
      phoneNumber: '', // سيتم جلبه من السيرفر أو تركه كما هو
      profileImage: '',
      nationality: _selectedNationality,
      nationalId: _idController.text.trim(),
    );

    context.read<AuthBloc>().add(UpdateProfileSubmitted(user: updatedUser));
  }
}

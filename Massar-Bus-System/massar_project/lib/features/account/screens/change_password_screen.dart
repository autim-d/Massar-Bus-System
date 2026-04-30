import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // إضافة الاستيراد
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import '../../../core/widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'تغيير كلمة المرور',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'ReadexPro',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: theme.iconTheme.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        // استخدام BlocConsumer للاستماع للنتائج وتغيير الواجهة
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is PasswordChangeSuccess) {
              // في حال النجاح (استخدام الحالة المخصصة الجديدة)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تغيير كلمة المرور بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();
            } else if (state is AuthError) {
              // إظهار خطأ في حال فشل الطلب من الباك أند
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'الرجاء إدخال كلمة المرور الحالية وكلمة المرور الجديدة.',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? theme.textTheme.bodySmall?.color
                            : const Color(0xFF667085),
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Current Password
                    CustomTextField(
                      controller: _currentPasswordController,
                      label: 'كلمة المرور الحالية',
                      hintText: '••••••••',
                      enabled: !isLoading, // تعطيل الحقل أثناء التحميل
                      isObscure: !_isCurrentPasswordVisible,
                      textDirection: TextDirection.ltr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isCurrentPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: theme.textTheme.bodyMedium?.color,
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => _isCurrentPasswordVisible =
                              !_isCurrentPasswordVisible,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // New Password
                    CustomTextField(
                      controller: _newPasswordController,
                      label: 'كلمة المرور الجديدة',
                      hintText: '••••••••',
                      enabled: !isLoading,
                      isObscure: !_isNewPasswordVisible,
                      textDirection: TextDirection.ltr,
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
                          _isNewPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: theme.textTheme.bodyMedium?.color,
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => _isNewPasswordVisible = !_isNewPasswordVisible,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Confirm New Password
                    CustomTextField(
                      controller: _confirmPasswordController,
                      label: 'تأكيد كلمة المرور الجديدة',
                      hintText: '••••••••',
                      enabled: !isLoading,
                      isObscure: !_isConfirmPasswordVisible,
                      textDirection: TextDirection.ltr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        if (value != _newPasswordController.text) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: theme.textTheme.bodyMedium?.color,
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Save Button
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // إرسال الحدث للـ Bloc للتعامل مع الباك أند
                                context.read<AuthBloc>().add(
                                  ChangePasswordRequested(
                                    currentPassword:
                                        _currentPasswordController.text,
                                    newPassword: _newPasswordController.text,
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1570EF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'حفظ التغييرات',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

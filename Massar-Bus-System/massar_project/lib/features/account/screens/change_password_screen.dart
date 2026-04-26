import 'package:flutter/material.dart';
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
        body: SingleChildScrollView(
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
                    color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                    fontFamily: 'ReadexPro',
                  ),
                ),
                const SizedBox(height: 32),
                
                // Current Password
                CustomTextField(
                  controller: _currentPasswordController,
                  label: 'كلمة المرور الحالية',
                  hintText: '••••••••',
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
                      _isCurrentPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: theme.textTheme.bodyMedium?.color,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _isCurrentPasswordVisible = !_isCurrentPasswordVisible),
                  ),
                ),
                const SizedBox(height: 16),
                
                // New Password
                CustomTextField(
                  controller: _newPasswordController,
                  label: 'كلمة المرور الجديدة',
                  hintText: '••••••••',
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
                      _isNewPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: theme.textTheme.bodyMedium?.color,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _isNewPasswordVisible = !_isNewPasswordVisible),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Confirm New Password
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'تأكيد كلمة المرور الجديدة',
                  hintText: '••••••••',
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
                      _isConfirmPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: theme.textTheme.bodyMedium?.color,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                  ),
                ),
                const SizedBox(height: 48),
                
                // Save Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulate password change success
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
                      );
                      Navigator.of(context).pop();
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
                  child: const Text(
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
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
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
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'يرجى ملء كافة البيانات التالية للبدء',
                    style: TextStyle(
                      fontFamily: 'ReadexPro',
                      fontSize: 14,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  CustomTextField(
                    controller: _firstNameController,
                    label: 'الاسم الأول',
                    hintText: 'أحمد',
                    validator: (value) => (value == null || value.isEmpty) ? 'الرجاء إدخال الاسم الأول' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _lastNameController,
                    label: 'الاسم الأخير',
                    hintText: 'باوزير',
                    validator: (value) => (value == null || value.isEmpty) ? 'الرجاء إدخال الاسم الأخير' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _emailController,
                    label: 'الإيميل',
                    hintText: 'ahmad.hatem959@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      }
                      final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
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
                          color: isDark ? const Color(0xFFD0D5DD) : const Color(0xFF344054),
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
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildGenderButton(
                              label: 'أنثى',
                              value: 'female',
                              icon: Icons.female,
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
                          color: isDark ? const Color(0xFFD0D5DD) : const Color(0xFF344054),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1D2939) : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : const Color(0xFFD0D5DD),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedDialCode,
                                items: ['+967', '+966', '+20', '+971'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'ReadexPro',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: theme.textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() => _selectedDialCode = val!),
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
                              validator: (value) => (value == null || value.isEmpty) ? 'الرجاء إدخال رقم الجوال' : null,
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
                        color: const Color(0xFF667085),
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
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.go('/home');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
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
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child:  Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontFamily: 'ReadexPro',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? const Color(0xFF5491F5) : const Color(0xFF1570EF),
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
  }

  Widget _buildGenderButton({
    required String label,
    required String value,
    required IconData icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = value),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6)
              : (isDark ? const Color(0xFF1D2939) : Colors.white),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : (isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFD0D5DD)),
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
                  : (isDark ? const Color(0xFF98A2B3) : const Color(0xFF667085)),
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
                    : (isDark ? const Color(0xFF98A2B3) : const Color(0xFF667085)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

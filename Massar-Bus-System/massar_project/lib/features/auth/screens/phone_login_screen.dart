import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// تأكد من صحة مسارات استدعاء الـ BLoC حسب مجلدات مشروعك
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneCtrl = TextEditingController();

  // Default country code
  String _selectedDialCode = '+967'; // اليمن حسب طلبك
  bool _isValid = false;

  // List of country options (label, code). Add flags/assets if تريد لاحقاً.
  final List<Map<String, String>> _countries = const [
    {'name': 'اليمن', 'code': '+967'},
    {'name': 'المملكة العربية السعودية', 'code': '+966'},
    {'name': 'مصر', 'code': '+20'},
    {'name': 'الكويت', 'code': '+965'},
    {'name': 'الإمارات', 'code': '+971'},
  ];

  @override
  void initState() {
    super.initState();
    _phoneCtrl.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _phoneCtrl.removeListener(_onPhoneChanged);
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    final text = _phoneCtrl.text.trim();
    // only digits accepted by input formatter, check length == 9
    final valid = RegExp(r'^\d{9}$').hasMatch(text);
    if (valid != _isValid) {
      setState(() {
        _isValid = valid;
      });
    }
  }

  // Validator for form submit (keeps message consistent)
  String? _phoneValidator(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'الرجاء إدخال رقم الجوال';
    if (!RegExp(r'^\d+$').hasMatch(v))
      return 'يجب أن يحتوي الرقم على أرقام فقط';
    if (v.length != 9) return 'يجب أن يتكون الرقم من 9 أرقام';
    return null;
  }

  // دالة الإرسال المربوطة بالـ BLoC
  void _onContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      // إخفاء لوحة المفاتيح
      FocusScope.of(context).unfocus();

      // دمج مفتاح الدولة مع الرقم (بدون مسافات ليقبله الـ API بسهولة)
      final fullNumber = '$_selectedDialCode${_phoneCtrl.text}';

      // إرسال حدث للـ Bloc ليتواصل مع خادم Laravel
      context.read<AuthBloc>().add(SendOtpRequested(phone: fullNumber));
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final horizontalPadding = w * 0.08; // تقريباً نفس المسافات في التصميم

    // إضافة BlocConsumer للاستماع لحالات الاتصال بالسيرفر
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSentSuccess) {
          // السيرفر أرسل الـ SMS بنجاح، ننتقل لصفحة إدخال الرمز
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'تم إرسال الرمز بنجاح إلى: ${state.phone}',
                style: const TextStyle(fontFamily: 'air'),
              ),
              backgroundColor: Colors.green,
            ),
          );
          // الانتقال مع تمرير الرقم للشاشة التالية
          context.push('/verification', extra: state.phone);
        } else if (state is AuthError) {
          // فشل الإرسال (مشكلة في السيرفر أو الرقم)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(fontFamily: 'air'),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        // التحقق من حالة التحميل
        final isLoading = state is AuthLoading;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 28),

                    // Logo
                    SizedBox(
                      height: 120,
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo2.png',
                          fit: BoxFit.contain,
                          width: w * 0.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Label "رقم الجوال"
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'رقم الجوال',
                        style: TextStyle(
                          fontFamily: 'air',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Phone input with country selector inside a bordered container
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              // تظليل الخلفية إذا كان في حالة تحميل
                              color: isLoading
                                  ? Colors.grey.shade100
                                  : Colors.white,
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Row(
                              children: [
                                // Expanded phone input
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: TextFormField(
                                      controller: _phoneCtrl,
                                      keyboardType: TextInputType.number,
                                      textDirection: TextDirection
                                          .ltr, // numbers appear ltr
                                      enabled:
                                          !isLoading, // تعطيل الإدخال أثناء التحميل
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(9),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: '777777777',
                                        hintStyle: TextStyle(
                                          fontFamily: 'air',
                                          color: Colors.grey.shade400,
                                          letterSpacing: 2,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                      ),
                                      validator: _phoneValidator,
                                    ),
                                  ),
                                ),

                                // vertical divider
                                Container(
                                  width: 1,
                                  height: 44,
                                  color: Colors.grey.shade200,
                                ),

                                // Country dropdown
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedDialCode,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      // تعطيل القائمة المنسدلة أثناء التحميل
                                      onChanged: isLoading
                                          ? null
                                          : (val) {
                                              if (val == null) return;
                                              setState(() {
                                                _selectedDialCode = val;
                                              });
                                            },
                                      items: _countries.map((c) {
                                        return DropdownMenuItem<String>(
                                          value: c['code'],
                                          child: Text(
                                            '${c['code']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Error text display (from validator)
                          Builder(
                            builder: (context) {
                              final state = Form.of(context);
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(height: 0, child: Offstage()),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        // تعطيل الزر في حال كان الإدخال غير صالح أو التطبيق في حالة تحميل
                        onPressed: (_isValid && !isLoading)
                            ? _onContinue
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          disabledBackgroundColor: const Color(0xFF9BB7FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          shadowColor: const Color(0x332563EB),
                        ),
                        // عرض مؤشر التحميل إذا كان ينتظر السيرفر
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
                                'إستمرار',
                                style: TextStyle(
                                  fontFamily: 'air',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Bottom small text: تسجيل الدخول
                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                              // الانتقال لصفحة تسجيل الدخول بالبريد
                              context.push('/login');
                            },
                      child: Text.rich(
                        TextSpan(
                          text: 'لديك حساب سابق؟ ',
                          style: TextStyle(
                            fontFamily: 'air',
                            color: Colors.grey.shade600,
                          ),
                          children: const [
                            TextSpan(
                              text: 'تسجيل الدخول',
                              style: TextStyle(
                                fontFamily: 'air',
                                color: Color(0xFF2563EB),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

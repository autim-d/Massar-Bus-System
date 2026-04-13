// lib/pages/phone_login.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:massar_project/features/auth/screens/verification_method_screen.dart';


class phonelogin extends StatefulWidget {
  const phonelogin({super.key});

  @override
  State<phonelogin> createState() => _phoneloginState();
}

class _phoneloginState extends State<phonelogin> {
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
    if (!RegExp(r'^\d+$').hasMatch(v)) return 'يجب أن يحتوي الرقم على أرقام فقط';
    if (v.length != 9) return 'يجب أن يتكون الرقم من 9 أرقام';
    return null;
  }

  void _onContinue() {
  // show validation errors if any
  if (_formKey.currentState?.validate() ?? false) {
    final fullNumber = '$_selectedDialCode ${_phoneCtrl.text}';

    // نعرض Snackbar للمستخدم لإعلامه أن الرمز سيُرسل
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('سيُرسل رمز إلى: $fullNumber')),
    );

    // ننتقل بعد تأخير قصير حتى يرى المستخدم الـ Snackbar
    Future.delayed(const Duration(milliseconds: 450), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const VerificationMethodPage(phoneNumber: '777777777',)),
      );
    });
  } else {
    // إظهار الأخطاء إن وُجدت
    setState(() {});
  }
}


  @override
  Widget build(BuildContext context) {
    
    final w = MediaQuery.of(context).size.width;
    final horizontalPadding = w * 0.08; // تقريباً نفس المسافات في التصميم
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
            child: Column(
              children: [
                const SizedBox(height: 28),

                // Logo (تأكد من وضع الملف assets/images/logo.png)
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo2.png',
                      fit: BoxFit.contain,
                      // يمكنك تعديل الحجم بحسب الحاجة
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
                      // custom decorated container that mimics the design
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300, width: 1),
                          color: Colors.white,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Row(
                          children: [
                            // Expanded phone input
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: TextFormField(
                                  controller: _phoneCtrl,
                                  keyboardType: TextInputType.number,
                                  textDirection: TextDirection.ltr, // numbers appear ltr
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
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  validator: _phoneValidator,
                                ),
                              ),
                            ),

                            // vertical divider
                            Container(width: 1, height: 44, color: Colors.grey.shade200),

                            // Country dropdown
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedDialCode,
                                  icon: const Icon(Icons.keyboard_arrow_down),
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
                                  onChanged: (val) {
                                    if (val == null) return;
                                    setState(() {
                                      _selectedDialCode = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Error text display (from validator) — shown after interaction
                      Builder(builder: (context) {
                        // show field error manually under the container if exists
                        // ignore: unused_local_variable
                        final state = Form.of(context);
                        // We rely on autovalidate mode; but to ensure immediate feedback, we can call validate on tap attempt
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 0,
                              child: Offstage(), // keep layout compact; real errors come from TextFormField
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Continue button (active only when _isValid == true)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isValid ? _onContinue : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      disabledBackgroundColor: const Color(0xFF9BB7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0x332563EB),
                    ),
                    
                    child: Text(
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
                  onTap: () {
                    // Navigator to login page if exists
                    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ExistingLoginPage()));
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'لديك حساب سابق؟ ',
                      style: TextStyle(fontFamily: 'air', color: Colors.grey.shade600),
                      children: [
                        TextSpan(
                          text: 'تسجيل الدخول',
                          style: TextStyle(
                            fontFamily: 'air',
                            color: const Color(0xFF2563EB),
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
  }
}

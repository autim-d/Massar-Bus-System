// lib/pages/login.dart
import 'package:flutter/material.dart';
import 'package:massar_project/Bawazir_Screens/Pages/phonelogin.dart';

/// صفحة تسجيل (Login / Profile form)
/// متطلبات:
/// - تأكد أن الخط 'air' معرف في pubspec.yaml
/// - استبدل SuccessPage() أو تعديل التنقل حسب مشروعك
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Controllers
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  // Gender value: 'male' or 'female' or empty
  String _gender = '';

  // Button enabled flag
  bool _isFormValid = false;
  bool _autoValidate = false; // show validation after first submit attempt

  @override
  void initState() {
    super.initState();
    // Listen to text changes to re-check form validity
    _firstNameCtrl.addListener(_checkFormValid);
    _lastNameCtrl.addListener(_checkFormValid);
    _emailCtrl.addListener(_checkFormValid);
  }

  @override
  void dispose() {
    _firstNameCtrl.removeListener(_checkFormValid);
    _lastNameCtrl.removeListener(_checkFormValid);
    _emailCtrl.removeListener(_checkFormValid);
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  // Email validation helper
  bool _isValidEmail(String input) {
    final emailReg = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailReg.hasMatch(input.trim());
  }

  // Recompute form validity and update button state
  void _checkFormValid() {
    final first = _firstNameCtrl.text.trim();
    final last = _lastNameCtrl.text.trim();
    final email = _emailCtrl.text.trim();

    final fieldsNotEmpty = first.isNotEmpty && last.isNotEmpty && email.isNotEmpty && _gender.isNotEmpty;
    final emailOk = _isValidEmail(email);

    final valid = fieldsNotEmpty && emailOk;
    if (valid != _isFormValid) {
      setState(() {
        _isFormValid = valid;
      });
    }
  }

  void _onSubmit() {
    setState(() => _autoValidate = true);

    // Validate form fields
    if (_formKey.currentState?.validate() ?? false) {
      // كل شيء صحيح -> تنفيذ أي منطق (API, حفظ...) ثم التنقل
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const phonelogin()),
      );
    } else {
      // لا ننتقل، نعرض رسالة مُختصرة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تصحيح الحقول قبل المتابعة')),
      );
    }
  }

  // Custom radio button widget matching التصميم
  Widget _buildCustomRadio(String value, String label) {
       
    final selected = _gender == value;
    return InkWell(
      onTap: () {
        setState(() {
          _gender = value;
        });
        _checkFormValid();
      },
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? const Color(0xFF2563EB) : Colors.grey.shade400,
                width: selected ? 2.4 : 1.4,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use RTL direction around this page (to be safe if not set globally)
    final w = MediaQuery.of(context).size.width;
    final horizontalPadding = w * 0.06;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 28),
            child: Form(
              key: _formKey,
              autovalidateMode:
                  _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    'إملأ الحقول أدناه بالبيانات التالية:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'air',
                      fontSize: w * 0.065,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'قبل إستخدام هذا التطبيق ، من فضلك إملأ معلوماتك',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'air',
                      fontSize: w * 0.036,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 26),

                  // First name label + field
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'الاسم الأول',
                      style: TextStyle(
                        fontFamily: 'air',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameCtrl,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'أحمد',
                      hintStyle: TextStyle(fontFamily: 'air'),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'هذا الحقل مطلوب';
                      return null;
                    },
                  ),

                  SizedBox(height: 18),

                  // Last name
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'الإسم الأخير',
                      style: TextStyle(
                        fontFamily: 'air',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameCtrl,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'باوزير',
                      hintStyle: TextStyle(fontFamily: 'air'),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'هذا الحقل مطلوب';
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // Gender row (label on right, radios on left visually)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontFamily: 'air',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Row(
                        children: [
                          _buildCustomRadio('male', 'ذكر'),
                          const SizedBox(width: 12),
                          _buildCustomRadio('female', 'أنثى'),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Email
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'الإيميل',
                      style: TextStyle(
                        fontFamily: 'air',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr, // emails are LTR
                    decoration: InputDecoration(
                      hintText: 'ahmad.hatem959@gmail.com',
                      hintStyle: TextStyle(fontFamily: 'air'),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'هذا الحقل مطلوب';
                      if (!_isValidEmail(v)) return 'أدخل بريدًا إلكترونيًا صالحًا';
                      return null;
                    },
                  ),

                  const SizedBox(height: 28),

                  // Submit button: مفعل فقط إذا _isFormValid == true
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isFormValid ? _onSubmit : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        disabledBackgroundColor: const Color(0xFF9BB7FF), // disabled shade
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 6,
                        shadowColor: const Color(0x552563EB),
                      ),
                      child: Text(
                        'كل شي جاهز',
                        style: TextStyle(
                          fontFamily: 'air',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// صفحة نجاح بسيطة (يمكن تغييرها أو ربطها بصفحة أخرى في المشروع)
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تم'),
          backgroundColor: const Color(0xFF2563EB),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, size: 84, color: Color(0xFF2563EB)),
              SizedBox(height: 16),
              Text(
                'تم إرسال البيانات بنجاح!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

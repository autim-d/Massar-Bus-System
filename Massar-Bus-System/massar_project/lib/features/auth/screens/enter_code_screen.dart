import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/core/theme/app_colors.dart';


class EnterCodeScreen extends StatefulWidget {
  final String phoneNumber;
  const EnterCodeScreen({super.key, required this.phoneNumber});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final int fieldsCount = 4;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  bool _isPasting = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(fieldsCount, (_) => TextEditingController());
    _focusNodes = List.generate(fieldsCount, (_) => FocusNode());

    for (var i = 0; i < fieldsCount; i++) {
      _controllers[i].addListener(() => _onFieldChanged(i));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onFieldChanged(int index) {
    final text = _controllers[index].text;

    if (text.length > 1 && !_isPasting) {
      _isPasting = true;
      final all = text.replaceAll(RegExp(r'[^0-9]'), '');
      for (var i = 0; i < fieldsCount; i++) {
        _controllers[i].text = i < all.length ? all[i] : '';
      }
      _isPasting = false;

      for (var i = 0; i < fieldsCount; i++) {
        if (_controllers[i].text.isEmpty) {
          _focusNodes[i].requestFocus();
          return;
        }
      }
      _trySubmit();
      return;
    }

    // إذا أدخل حرفًا انتقل للفوكس التالي
    if (text.isNotEmpty) {
      if (index + 1 < fieldsCount) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // الحقل الأخير معبأ -> محاولة الإرسال التلقائي
        _trySubmit();
      }
    }
  }

  // محاولة الإرسال إن اكتملت الحقول
  void _trySubmit() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == fieldsCount && RegExp(r'^\d+$').hasMatch(code)) {
      // تأخير بسيط لتحسين الـ UX ثم التنقّل
      Future.delayed(const Duration(milliseconds: 250), () {
        if (!mounted) return;
        // استبدل HomeScreen() باسم الصفحة الرئيسية في مشروعك إن اختلف
        context.go('/home');
      });
    }
  }

  // إعادة الإرسال -> نعيد التوجيه إلى VerificationMethodScreen
  void _onResend() {
    context.pushReplacement('/verification', extra: widget.phoneNumber);
  }

  // بناء مربع رقم واحد
  Widget _buildBox(int index, double boxSize) {
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: RawKeyboardListener(
        focusNode: FocusNode(), // listening to backspace
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            // لو الخانة الحالية فارغة نرجع للخانة السابقة
            if (_controllers[index].text.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
              _controllers[index - 1].text = '';
            }
          }
        },
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.grey.shade900),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.backgroundLight,
            contentPadding: const EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.mainButton, width: 1.6),
            ),
          ),
          // onChanged يُستخدم أيضاً لالتقاط الحذف عبر واجهات الهواتف حيث لا تعمل RawKeyboard
          onChanged: (v) {
            if (v.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
            // _onFieldChanged سيتم استدعاؤه عبر listener على الـ controller
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone = widget.phoneNumber;
    // ignore: unused_local_variable
    final w = MediaQuery.of(context).size.width;
    final horizontalPadding = 24.0;
    final boxSize = 58.0; // مطابق للصورة
    final boxSpacing = 12.0; // المسافة بين الصناديق

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundDark,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.secondaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: 6),

                const Text(
                  'أدخل رمز التأكيد',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 8),

                Text(
                  'لقد أرسلنا رسالة إلى رقمك',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  phone,
                  style: const TextStyle(fontSize: 14, color: AppColors.secondaryColor, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 28),

                // صف الحقول بأبعاد وتباعد مطابقين
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(fieldsCount, (i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: boxSpacing / 2),
                      child: _buildBox(i, boxSize),
                    );
                  }),
                ),

                const SizedBox(height: 22),

                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                      children: [
                        const TextSpan(text: 'لم تستلم الرسالة؟ '),
                        TextSpan(
                          text: 'أعد الإرسال',
                          style: const TextStyle(color: AppColors.textEdit, fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()..onTap = _onResend,
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

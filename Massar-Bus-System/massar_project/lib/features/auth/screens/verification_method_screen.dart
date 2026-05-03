import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';


// تأكد أن ملف EnterCodeScreen موجود في المسار التالي
// import 'EnterCodeScreen.dart';

class VerificationMethodScreen extends StatelessWidget {
  // نمرر رقم الهاتف لعرضه داخل البطاقة
  final String phoneNumber;

  const VerificationMethodScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final horizontalPadding = w * 0.06;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // AppBar مخصص خفيف (سطر علوي به زر رجوع)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
                child: Row(
                  children: [
                    // زر الرجوع (السهم إلى اليسار)
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, size: 24),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // المحتوى الوسطي
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),

                        // العنوان
                        Text(
                          'طريقة التحقق',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'air', // تأكد من تعريف الخط في pubspec
                            fontSize: w * 0.062,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade900,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // الوصف الصغير
                        Text(
                          'إختر طريقة التحقق من المذكورة أدناه',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'air',
                            fontSize: w * 0.036,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // بطاقة واتساب قابلة للضغط
                        GestureDetector(
                          onTap: () {
                            // عند الضغط ننتقل لصفحة EnterCodeScreen مع تمرير رقم الهاتف
                            context.push('/otp', extra: phoneNumber);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // أيقونة واتساب على اليمين (لأن الصفحة RTL)
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF25D366), // whatsapp green
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Bootstrap.whatsapp, // من icons_plus
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // نص الوسم (واتساب إلى) والرقم أسفله
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'واتساب إلى',
                                        style: TextStyle(
                                          fontFamily: 'air',
                                          fontSize: w * 0.038,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      // الرقم أسفل الوسم كما طلبت
                                      Text(
                                        phoneNumber,
                                        style: TextStyle(
                                          fontFamily: 'air',
                                          fontSize: w * 0.034,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // سهم بسيط على اليسار (يشير إلى أن البطاقة قابلة للضغط)
                                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // أي محتوى إضافي (إتركه فارغاً أو أضف خيارات أخرى)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

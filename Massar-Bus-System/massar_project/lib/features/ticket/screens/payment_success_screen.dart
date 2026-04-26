import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/core/theme/app_colors.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, // Keep white
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            const baseWidth = 430.0;
            const baseHeight = 932.0;

            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final wScale = width / baseWidth;
            final hScale = height / baseHeight;

            double scale(double size) => size * ((wScale + hScale) / 2);

            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: scale(25),
                    vertical: scale(40),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ===== الصورة المركزية =====
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/Shapes.png',
                              width: scale(230),
                              height: scale(150),
                              fit: BoxFit.contain,
                            ),
                            Image.asset(
                              'assets/images/paymentsuccess.png',
                              width: scale(100),
                              height: scale(100),
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: scale(20)),
                      Text(
                        'تم الدفع بنجاح',
                        style: TextStyle(
                          fontSize: scale(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: scale(30)),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: scale(20),
                          vertical: scale(20),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(scale(15)),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // معرّف الطلب
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'معرّف الطلب:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '1502241552',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: scale(15)),

                            // طريقة الدفع مع أيقونة gopay
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'طريقة الدفع:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'gopay',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: scale(6)),
                                    Image.asset(
                                      'assets/icons/BuyIcon.png',
                                      width: scale(16),
                                      height: scale(16),
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: scale(15)),

                            // التاريخ والوقت
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'التاريخ والوقت:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '19 فبراير، 2024 الساعة 04:15 مساءً',
                                  style: TextStyle(
                                    fontSize: scale(12),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: scale(50)),

                      // ===== زر عرض التذكرة =====
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainButton,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(scale(8)),
                            ),
                          ),
                          onPressed: () {
                            // Using push here to keep it on top of the payment flow or go to tickets branch?
                            // Actually, DetailTicketScreen is a sub-route of /tickets
                            context.push('/tickets/detail');
                          },
                          child: Text(
                            'عرض التذكرة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSave,
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
        ),
      ),
    );
  }
}

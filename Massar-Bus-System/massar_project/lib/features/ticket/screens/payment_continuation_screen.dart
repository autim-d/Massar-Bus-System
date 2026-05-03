import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/features/ticket/screens/payment_success_screen.dart';

class PaymentContinuationScreen extends StatelessWidget {
  const PaymentContinuationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        // <-- Important: RTL Layout
        textDirection: TextDirection.rtl,
      
        child: Scaffold(
          backgroundColor: Color(0xffffffff),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            title: Padding(
              padding: EdgeInsetsGeometry.only(top: 17),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 60),
                    child: const Text(
                      "مواصلة الدفع",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const Text(
                    " معرف الطلب :1502241552",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
      
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text("طريقة الدفع"),
                      _buildStepFirstCircle("1", isActive: true),
                      _buildStepDivider(),
                      Text("ادفع"),
                      _buildStepCircle("2"),
                      _buildStepDivider(),
                      Text("إنهاء"),
                      _buildStepCircle("3"),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.mainButton, Color(0xff2E90FA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "الانتهاء في :",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("59")),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.only(right: 5),
                            child: Text(
                              ":",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("01")),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.only(right: 5),
                            child: Text(
                              ":",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("00")),
                      ),
                      SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: 10,
                    left: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    width: 375,
                    height: 145,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5D2D2), width: .7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ---------------- السطر الأول: التاريخ ----------------
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            
                            children: [
                              Container(
                                child: Text(
                                  "اثنين, 18 سبتمبر 2025",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
      
                        SizedBox(height: 16),
      
                        /// ---------------- السطر الثاني: التوقف الحالي + الوجهة ----------------
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "التوقف الحالي",
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "الإنشاءات",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 5),
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF9FAFB),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xffE5D2D2),
                                      ),
                                    ),
                                    child: Text(
                                      "الوصول المتوقع: 30 دقيقة",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsGeometry.only(
                                          right: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.place,
                                              color: AppColors.destenation,
                                              size: 20,
                                            ),
                                            SizedBox(width: 4),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsetsGeometry.only(
                                                        left: 30,
                                                      ),
                                                  child: Text(
                                                    "الوجهة",
                                                    style: TextStyle(
                                                      color: AppColors.textSecondary,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "المتضررين",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(

                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white10,
                                elevation: 0,
                              ),
                              child: Text(
                                "تفاصيل الطلب",
                                style: TextStyle(
                                  color: AppColors.textEdit,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  
                                ),
                              ),
                            ),
                          ),
                        ),
      
                        /// ---------------- السطر الرابع: الباص ----------------
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 20,
                  thickness: 8,
                  color: Color(0xffF2F4F7),
                ),
                SizedBox(height: 20),
      
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    "طريقة الدفع",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
      
                const SizedBox(height: 10),
      
                Padding(
                  padding: EdgeInsetsGeometry.only(right: 20, left: 20),
                  child: Container(
                    width: 375,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Image.asset(  
                              "assets/images/vector.png",
                              width: 50,
                              height: 40,
                            ),
                            SizedBox(width: 10),
                            const Text(
                              "Mandiri VA",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsetsGeometry.only(left: 15),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "تغيير",
                                  style: TextStyle(
                                    color: AppColors.textEdit,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
      
                        const SizedBox(height: 10),
                        Divider(thickness: 0.3, color: Colors.grey),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(right: 7),
                              child: Text(
                                "استخدام الحساب الافتراضي سيضيف رسوم إضافية",
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsetsGeometry.only(left: 10),
                              child: Container(
                                width: 70,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(0xffF9FAFB),
                                  border: Border.all(
                                    color: AppColors.grey200,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: Text(" 800+ ريال")),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 20,
                  thickness: 8,
                  color: Color(0xffF2F4F7),
                ),
                const SizedBox(height: 20),
      
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 10, right: 15, top: 10),
                  child: Container(
                    width: 360,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey200, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/promo.svg",
                        width: 24,
                        height: 24,
                      ),
                      title: const Text(
                        "استخدم العرض الترويجي",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.green,
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
      
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 375,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey200, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsetsGeometry.only(right: 3),
                                  child: Text(
                                    " معلومة مهمة",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff475467),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "الدفع يتم فقط عن طريق بنك بن دول ولا يمكن استبداله ",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
      
                      const SizedBox(height: 8),
      
                      const SizedBox(height: 8),
      
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            const TextSpan(
                              text: "بالضغط على زر الدفع، فإنك توافق على ",
                            ),
                            TextSpan(
                              text: "الشروط والأحكام",
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: " و "),
                            TextSpan(
                              text: "سياسة الخصوصية",
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                  Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 20,
                  thickness: 8,
                  color: Color(0xffF2F4F7),
                ),
                const SizedBox(height: 10),
      
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "تفاصيل الدفع",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
      
                      const SizedBox(height: 10),
      
                      _buildPriceRow("سعر التذكرة", " 10000 ريال يمني"),
                      const Divider(height: 15),
                      _buildPriceRow("الحماية", " 10000 ريال يمني"),
                      const Divider(height: 15),
                      _buildPriceRow("راحة", " 10000 ريال يمني"),
      
                      _buildPriceRow("الإجمالي", " 30000 ريال يمني", isTotal: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
      
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainButton,
                ),
                child: const Text(
                  "الدفع باستخدام بن دول باي",
                  
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String title, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isTotal ?  Colors.black :AppColors.textSecondary , 
              fontSize: isTotal ? 17 : 15,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 17 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
              color: isTotal ? AppColors.mainButton : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(String number, {bool isActive = false}) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xffEFF8FF) : Color(0xffEFF8FF),
        border: Border.all(color: Color(0xffD0D5DD), width: 1),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStepFirstCircle(String number, {bool isActive = false}) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xffEFF8FF) : Color(0xffEFF8FF),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStepDivider() {
    return SizedBox(
      child: Container(height: 2, width: 70, color: Colors.grey.shade300),
    );
  }
}




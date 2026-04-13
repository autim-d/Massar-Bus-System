import 'package:flutter/material.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/features/ticket/screens/payment_continuation_screen.dart';

class Ordersummary extends StatefulWidget {
  const Ordersummary({super.key});

  @override
  State<Ordersummary> createState() => _OrdersummaryState();
}

class _OrdersummaryState extends State<Ordersummary> {
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
                    padding: EdgeInsetsGeometry.only(left: 60, bottom: 20),
                    child: const Text(
                      "تذكرة اختيارك",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(thickness: 1.5),
                SizedBox(height: 35),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: 10,
                    left: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: 375,
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5D2D2), width: .7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ---------------- السطر الأول: التاريخ ----------------
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),

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
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_bus,
                                color: Color(0xff667085),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "الباص 01 - الوصول في 15:30 الى الشرج  ",
                                style: TextStyle(color: Color(0xff667085)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(right: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "الاسرع",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Color(0xffE5D2D2)),
                              ),
                              child: Text("مختلط"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Divider(thickness: .7, indent: 0, endIndent: 0),
                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                color: AppColors.location,
                                size: 31,
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsGeometry.only(left: 10),
                                    child: Text(
                                      "العمل",
                                      style: TextStyle(
                                        color: Color(0xff667085),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "موقعك",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            right: 34,
                            bottom: 5,
                          ),
                          child: Container(
                            width: 60,
                            height: 23,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffEAECF0)),
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffF9FAFB),
                            ),
                            child: Center(child: Text("10 دقائق")),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bus_alert_outlined,
                                color: AppColors.iconOf,
                                size: 31,
                              ),
                              SizedBox(width: 10),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsGeometry.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        "الوقوف",
                                        style: TextStyle(
                                          color: Color(0xff667085),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsGeometry.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        "الشرج",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 60,
                                      height: 23,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xffEAECF0),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xffF9FAFB),
                                      ),
                                      child: Center(child: Text("10 دقائق")),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 10),
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_on , color: const Color.fromARGB(255, 245, 153, 103),),
                              SizedBox(width: 10),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsGeometry.only(
                                        left: 10,
                                      ),
                                      child: Text(
                                        "اليوم",
                                        style: TextStyle(
                                          color: Color(0xff667085),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "الاثنين",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    "تتبع الباص ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                          child: Container(
                            width: 330,
                            height: 130,
                            child: Image.asset(
                              "assets/images/maps.png",
                              width: 340,
                              height: 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                  padding: EdgeInsetsGeometry.only(right: 10, left: 10),
                  child: Container(
                    width: 350,
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffEAECF0), width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                right: 20,
                                top: 10,
                              ),
                              child: Text(
                                "خليل سيلان",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                left: 20,
                                top: 10,
                              ),
                              child: Icon( Icons.edit_square,
                                  color: AppColors.iconOf, size: 30),)
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                right: 20,
                                top: 10,
                              ),
                              child: Text(
                                "khalilabraheem053@gmail.com",
                                style: TextStyle(
                                  color: Color(0xff667085),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                right: 20,
                                top: 10,
                              ),
                              child: Text(
                                " 776463185 967+",
                                style: TextStyle(
                                  color: Color(0xff667085),
                                  fontSize: 16,
                                ),
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

                      _buildPriceRow(
                        "الإجمالي",
                        " 30000 ريال يمني",
                        isTotal: true,
                      ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>PaymentContinuationScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainButton,
                ),
                child: const Text(
                  "اختيار طريقة الدفع",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSave,
                    fontWeight: FontWeight.w800,
                  ),
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
              color: isTotal ? Colors.black : Color(0xff667085),
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
              color: isTotal ? AppColors.textEdit : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

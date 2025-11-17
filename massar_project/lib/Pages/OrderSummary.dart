import 'package:flutter/material.dart';


class Ordersummary extends StatefulWidget {
  const Ordersummary({super.key});

  @override
  State<Ordersummary> createState() => _OrdersummaryState();
}
String selected = "no";

class _OrdersummaryState extends State<Ordersummary> {
  Widget buildOption({
    
    required bool selected,
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: selected,
            onChanged: (_) => onTap(),
            activeColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(icon, size: 18, color: Colors.green),
                  ],
                ),

                if (subtitle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
                    height: 390,
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
                              Image.asset(
                                "assets/images/Current.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 4),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsGeometry.only(
                                        left: 10,
                                      ),
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
                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/greenbu.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 4),
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

                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/destination.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 4),
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
                              SizedBox(height: 8),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

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
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.only(left: 20, right: 20),
                          child: Container(
                            width: 350,
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
                  padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 372,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffF79009),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                bottom: 140,
                                right: 0,
                              ),
                              child: Container(
                                width: 370,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffFFAC30),
                                      Color(0xffFFDA58),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsGeometry.only(
                                    right: 10,
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "احصل على حماية إضافية لرحلتك",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsGeometry.only(
                                          right: 90,
                                          bottom: 10,
                                        ),
                                        child: Image.asset(
                                          "assets/images/Heart.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1570EF),
                ),
                child: const Text(
                  "اختيار طريقة الدفع",
                  style: TextStyle(fontSize: 16, color: Colors.white,
                  fontWeight: FontWeight.w800
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
              color: isTotal ? Color(0xff1570EF) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

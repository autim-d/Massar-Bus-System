import 'package:flutter/material.dart';
import 'package:massar_project/features/ticket/screens/order_summary_screen.dart';
import 'package:massar_project/core/theme/app_colors.dart';
//import 'package:flutter/services.dart';
//import 'app_colors.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.close)),
          title: Text(
            "اين تريد الذهاب ؟",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 375,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xffF9FAFB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xffD0D5DD), width: 1.5),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 13, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: Color(0xff101828),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.only(right: 18),
                            child: Text(
                              "موقعك الحالي",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.textPrimary
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(height: 10, indent: 30, endIndent: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color:AppColors.textSecondary,
                          ),
                          hintText: "البحث عن وجهة",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Container(
                        width: 146,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF9FAFB),
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Row(
                          children: [
                            Icon( 
                              Icons.business_center,
                              size: 24,
                              color: Color(0xff344054),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.only(right: 10),
                              child: Text(
                                "مكاتب التخزين ",
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ordersummary(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 146,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF9FAFB),
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.bookmark,
                              size: 24,
                              color: Color(0xff344054),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.only(right: 15),
                              child: Text(
                                "حفظ الموقع",
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 51,
              thickness: 4,
              color: const Color.fromARGB(15, 0, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}

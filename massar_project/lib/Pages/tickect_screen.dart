
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int _currentIndex = 2;
  final List status = [
    {"name": "جميع الحالات"},
    {"name": "جميع انواع الرحلات "},
    {"name": "جميع انواع الباصات"},
    {"name": "كل التواريخ "},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
      
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: Color(0xff1570EF),
            unselectedItemColor: Color(0xff667085),
            showUnselectedLabels: true,
      
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  width: 24,
                  height: 24,
                ),
                label: "الصفحة الرئيسية",
              ),
      
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/myticket.svg',
                  width: 24,
                  height: 24,
                ),
                label: "تذكرتي",
              ),
      
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, -10),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xff1570EF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.confirmation_number, color: Colors.white),
                  ),
                ),
                label: "شراء",
              ),
      
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/offers.svg',
                  width: 24,
                  height: 24,),
                label: "الترويج",
              ),
      
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/account.svg',
                  width: 24,
                  height: 24,
                ),
                label: "الحساب",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.only(bottom: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 70, left: 10, right: 10),
                  child: Container(
                    width: 399,
                    height: 57,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xffE5D2D2), width: .7),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(right: 0, top: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 20),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return MaterialButton(
                          onPressed: () {},
                          child: Container(
                            width: 97,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffE5D2D2),
                                width: .7,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                status[index]['name'],
                                style: TextStyle(
                                  color: Color(0xff565353),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                  child: Container(
                    width: 375,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffE5D2D2), width: .7),
                      borderRadius: BorderRadius.circular(8),
                    ),
      
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// ---------------- السطر الأول: التاريخ ----------------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffECFDF3),
                                  border: Border.all(color: Color(0xffABEFC6)),
                                ),
                                child: Text(
                                  "نشط",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                    color: Color(0xff067647),
                                  ),
                                ),
                              ),
                            ],
                          ),
      
                          ///-----------------///
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
                                child: Text("مزج"),
                              ),
                            ],
                          ),
      
                          ///-----------------///
                          SizedBox(height: 16),
      
                          /// ---------------- السطر الثاني: التوقف الحالي + الوجهة ----------------
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsGeometry.only(right: 10),
                                child: Row(
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
                                              color: Color(0xff667085),
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
                              ),
                              Padding(
                                padding: EdgeInsetsGeometry.only(right: 13),
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
                                            right: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.place,
                                                color: Colors.orange,
                                                size: 20,
                                              ),
                                              SizedBox(width: 4),
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsGeometry.only(left: 30),
                                                      child: Text(
                                                        "الوجهة",
                                                        style: TextStyle(
                                                          color: Color(0xff667085),
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
      
                          SizedBox(height: 16),
      
                          SizedBox(height: 16),
      
                          /// ---------------- السطر الرابع: الباص ----------------
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
                                  "الباص 01 - الوصول الساعة 15:30 في محطة المتضررين",
                                  style: TextStyle(color: Color(0xff667085)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 375,
                        height: 270,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffE5D2D2), width: .7),
                          borderRadius: BorderRadius.circular(8),
                        ),
      
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ---------------- السطر الأول: التاريخ ----------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffECFDF3),
                                  border: Border.all(color: Color(0xffABEFC6)),
                                    ),
                                    child: Text(
                                      "نشط",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
      
                              ///-----------------///
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
                                      border: Border.all(
                                        color: Color(0xffE5D2D2),
                                      ),
                                    ),
                                    child: Text("مزج"),
                                  ),
                                ],
                              ),
      
                              ///-----------------///
                              SizedBox(height: 16),
      
                              /// ---------------- السطر الثاني: التوقف الحالي + الوجهة ----------------
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsGeometry.only(right: 10),
                                    child: Row(
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
                                                  color: Color(0xff667085),
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
                                  ),
                                  Padding(
                                    padding: EdgeInsetsGeometry.only(right: 13),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9FAFB),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                                                right: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.place,
                                                    color: Colors.orange,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsetsGeometry.only(left: 30),
                                                          child: Text(
                                                            "الوجهة",
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xff667085,
                                                              ),
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
      
                              SizedBox(height: 16),
      
                              SizedBox(height: 16),
      
                              /// ---------------- السطر الرابع: الباص ----------------
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
                                      "الباص 01 - الوصول الساعة 15:30 في محطة المتضررين",
                                      style: TextStyle(color: Color(0xff667085)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 355,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff1570EF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    "نهاية الدفع 00:24:40",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

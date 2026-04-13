// lib/pages/home.dart
import 'package:flutter/material.dart';
import 'package:massar_project/features/home/screens/location_search_screen.dart';
import 'package:massar_project/features/ticket/screens/order_summary_screen.dart';
import 'package:massar_project/features/ticket/screens/ticket_list_screen.dart';
import 'package:massar_project/features/ticket/screens/detail_ticket_screen.dart';
import 'package:massar_project/features/account/screens/account_screen.dart';
import 'package:massar_project/core/theme/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> savedPlaces = [
    {'label': 'بيتنا', 'icon': Icons.home},
    {'label': 'مكتبي', 'icon': Icons.work},
    {'label': 'أحمد', 'icon': Icons.person},
  ];

  final List<String> recentSearches = [
    'Monumen Nasional',
    'Central Park Mall',
    'Stasiun Gambir',
  ];

  static const Color primaryBlue = Color(0xFF2563EB);
  static const double _cardRadius = 14.0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final horizontalPadding = w * 0.06;
    final bannerHeight = h * 0.49; // ثابت ارتفاع البنر

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
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
                icon: IconButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => Home()),
                    ),
                  },
                  icon: Icon(
                    Icons.home,
                    color: _currentIndex == 0
                        ? Color(0xff1570EF)
                        : Color(0xff667085),
                  ),

                  // icon: SvgPicture.asset(
                  //   'assets/icons/account.svg',
                  //   width: 24,
                  //   height: 24,
                  // ),
                ),
                label: "الصفحة الرئيسية",
              ),
              BottomNavigationBarItem(
                // icon: SvgPicture.asset(
                //   'assets/icons/myticket.svg',
                //   width: 24,
                //   height: 24,
                // ),
                icon: IconButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => TicketScreen()),
                    ),
                  },
                  icon: Icon(
                    Icons.description_outlined,
                    color: _currentIndex == 1
                        ? Color(0xff1570EF)
                        : Color(0xff667085),
                  ),
                ),
                label: "تذكرتي",
              ),

              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, -15),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xff1570EF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const DetailTicketScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.confirmation_number,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                label: "شراء",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.mediation_rounded,
                  color: _currentIndex == 3
                      ? Color(0xff1570EF)
                      : Color(0xff667085),
                ),

                label: "الترويج",
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  color: _currentIndex == 4
                      ? Color(0xff1570EF)
                      : Color(0xff667085),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => Acount()),
                    ),
                  },
                  icon: Icon(Icons.person_2_rounded),
                ),
                label: "الحساب",
              ),
            ],
          ),
        ),

        body: SafeArea(
          child: Stack(
            children: [
              // ----------------
              // الصورة الثابتة للبنر في الخلفية مع BorderRadius.only(bottomLeft/bottomRight)
              // ----------------
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: bannerHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // صورة البنر بخاصية BorderRadius فقط في الأسفل
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      child: Image.asset(
                        'assets/images/Background3.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    // ------ النص فوق الصورة ------
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 190),
                          Text(
                            'صباح الخير يا خليل',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'air',
                              fontSize: w * 0.053,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textSave,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'أتمنى أن يكون يومك مشرقًا\nمثل الشمس',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'AirStripArabic',
                              fontSize: w * 0.034,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      bannerHeight -
                          40, // يخلق تداخل لطيف بين البنر ومحتوى الخريطة
                      horizontalPadding,
                      28,
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 90),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(_cardRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Inner map area with rounded corners at top
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(_cardRadius),
                                  topRight: Radius.circular(_cardRadius),
                                ),
                                child: Container(
                                  height: 120,
                                  color: Colors.grey.shade100,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.asset(
                                          'assets/images/map.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                                color: Colors.grey.shade100,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.map,
                                                    size: 48,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      // blue location dot (on top of map)
                                      Positioned(
                                        left: 20,
                                        top: 18,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2E9BFF),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Text area inside same card
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0,
                                  vertical: 12.0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'موقعك الحالي',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'AirStripArabic',
                                        fontSize: w * 0.038,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'المساكن · فوق، مدينة الملا · حضرموت',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'AirStripArabic',
                                        fontSize: w * 0.032,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Search destination card
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.chevron_left,
                                      color: Colors.grey.shade600,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) =>
                                              LocationSearchPage(),
                                        ),
                                      );
                                    },
                                  ),
                                  // child: const Icon(
                                  //   Icons.chevron_left,
                                  //   color: Colors.grey,
                                  // ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'ابحث عن وجهة',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontFamily: 'AirStripArabic',
                                          fontSize: w * 0.036,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: const BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              'حدد الموقع',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontFamily: 'AirStripArabic',
                                                fontSize: w * 0.032,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Saved places horizontal chips inside a card
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'الموقع المحفوظ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'AirStripArabic',
                                  fontSize: w * 0.036,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textSave,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 48,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: savedPlaces.length + 1,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, idx) {
                                    if (idx < savedPlaces.length) {
                                      final item = savedPlaces[idx];
                                      return InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                item['icon'] as IconData,
                                                size: 18,
                                                color: primaryBlue,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                item['label'] as String,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.02,
                                                ),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Recent searches
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'عمليات البحث السابقة الخاصة بك',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'AirStripArabic',
                                    fontSize: w * 0.034,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Column(
                                children: recentSearches.map((place) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 6,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            place,
                                            style: TextStyle(
                                              fontSize: w * 0.034,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.access_time,
                                          size: 18,
                                          color: Colors.grey.shade400,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 36),
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

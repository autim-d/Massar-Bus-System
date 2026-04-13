import 'package:flutter/material.dart';
import 'package:massar_project/features/home/screens/home_screen.dart';
import 'package:massar_project/features/ticket/screens/ticket_list_screen.dart';
import 'package:massar_project/features/ticket/screens/detail_ticket_screen.dart';
import 'package:massar_project/core/theme/app_colors.dart';

import 'package:massar_project/features/account/widgets/profile_header_widget.dart';
import 'package:massar_project/features/account/widgets/account_settings_card_widget.dart';
import 'package:massar_project/features/account/widgets/support_settings_card_widget.dart';

class Acount extends StatefulWidget {
  const Acount({super.key});

  @override
  State<Acount> createState() => _AcountState();
}

class _AcountState extends State<Acount> {
  int _currentIndex = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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
                    icon: Icon(Icons.confirmation_number, color: Colors.white),
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
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/images/h.jpg', width: 400),
              Positioned(
                bottom: -350,
                left: 0,
                right: 0,
                top: 45,

                child: Container(
                  height: 460,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const ProfileHeaderWidget(),
                      const SizedBox(height: 29),
                      const AccountSettingsCardWidget(),
                      const SizedBox(height: 25),
                      const SupportSettingsCardWidget(),
                    ],
                  ),
                ),
              ),
              // ==== Options Section ====
              // Expanded(
              //   child: SingleChildScrollView(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 20,
              //       vertical: 20,
              //     ),
              //     child: Column(
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //             borderRadius:BorderRadius.circular(10),
              //             boxShadow: [
              //               BoxShadow(
              //                 blurRadius: 2,
              //                 spreadRadius: 2,
              //                 offset: Offset(1, 2)
              //               )
              //             ]
              //           ),
              //           child: _buildCard([
              //             _buildListTile('حسابي'),
              //             _buildListTile('حفظ الموقع'),
              //           ]),
              //         ),
              //         const SizedBox(height: 12),
              //         _buildCard([
              //           _buildListTile('الدعم والمساعدة'),
              //           _buildListTile('أخبرنا بتجربتك مع التطبيق'),
              //           _buildListTile('الإعدادات'),
              //         ]),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/ticket/screens/ticket_list_screen.dart';
import '../../features/ticket/screens/detail_ticket_screen.dart';
import '../../features/account/screens/account_screen.dart';
// Note: We are using the old imports for now until we move those files too.

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const TicketListScreen(),
    const DetailTicketScreen(),
    const Center(child: Text("Promotion Screen Placeholder")), // Replace with actual later
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
          selectedItemColor: AppColors.mainButton,
          unselectedItemColor: AppColors.textSecondary,
          showUnselectedLabels: true,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "الصفحة الرئيسية",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: "تذكرتي",
            ),
            BottomNavigationBarItem(
              icon: Transform.translate(
                offset: const Offset(0, -15),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.mainButton,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.confirmation_number, color: Colors.white),
                ),
              ),
              label: "شراء",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.mediation_rounded),
              label: "الترويج",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: "الحساب",
            ),
          ],
        ),
      ),
    );
  }
}



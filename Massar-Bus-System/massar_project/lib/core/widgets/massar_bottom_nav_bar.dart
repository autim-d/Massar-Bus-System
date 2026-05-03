import 'package:flutter/material.dart';

class MassarBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MassarBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unselectedColor = isDark ? const Color(0xff98A2B3) : const Color(0xff667085);

    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1D2939) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.3) : Colors.black12,
            blurRadius: 6,
          )
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: const Color(0xff1570EF),
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: true,
        items: [
          _buildStandardItem(Icons.home, "الرئيسية"),
          _buildStandardItem(Icons.description_outlined, "تذكرتي"),
          _buildCenterActionItem(),
          _buildStandardItem(Icons.mediation_rounded, "الترويج"),
          _buildStandardItem(Icons.person_2_rounded, "الحساب"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildStandardItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  BottomNavigationBarItem _buildCenterActionItem() {
    return BottomNavigationBarItem(
      icon: Transform.translate(
        offset: const Offset(0, -20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xff1570EF),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff1570EF).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.confirmation_number, color: Colors.white, size: 28),
        ),
      ),
      label: "شراء",
    );
  }
}

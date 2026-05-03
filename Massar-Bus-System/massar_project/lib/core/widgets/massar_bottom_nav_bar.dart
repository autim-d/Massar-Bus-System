import 'package:massar_project/core/theme/app_colors.dart';
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.mainButton,
        unselectedItemColor: AppColors.textSecondary,
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
    );
  }
}



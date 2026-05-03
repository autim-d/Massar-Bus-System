import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ─────────────────────────────────────────────────────────────────────────────
/// The persistent shell that wraps all main-app branches.
///
/// Renders a custom 5-tab bottom navigation bar that matches the Massar design:
///
///   [الرئيسية]  [تذكرتي]  [● شراء ●]  [الترويج]  [الحساب]
///
/// The centre "شراء" item is elevated 18 px above the bar surface with a
/// filled blue circle, identical to the original per-screen BottomNavigationBar
/// that is being removed in Phase C.
///
/// Tab → Branch mapping (mirrors [app_router.dart]):
///   0 → /home          الصفحة الرئيسية
///   1 → /tickets       تذكرتي
///   2 → /buy           شراء
///   3 → /booking       حجز
///   4 → /account       الحساب
// ─────────────────────────────────────────────────────────────────────────────
class ShellNavigationScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellNavigationScreen({
    super.key,
    required this.navigationShell,
  });

  // Delegate tab taps to GoRouter's StatefulNavigationShell.
  // Tapping the already-active tab pops its branch back to its initial route.
  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      // extendBody lets the body scroll under the nav bar so screens that use
      // SafeArea(bottom: true) are not clipped.
      extendBody: true,
      bottomNavigationBar: _MassarBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// The custom bottom navigation bar widget.
///
/// Built as a plain [Container] + [Row] rather than Flutter's built-in
/// [BottomNavigationBar] so we have full control over the elevated centre
/// FAB-style button without fighting the framework's layout constraints.
// ─────────────────────────────────────────────────────────────────────────────
class _MassarBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _MassarBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  // ── Design tokens ───────────────────────────────────────────────────────────
  static const _selectedColor = AppColors.mainButton;
  static const _unselectedColor = AppColors.textSecondary;
  static const _barHeight = 72.0;
  // How many pixels the centre button floats above the bar top edge.
  static const _fabRise = 18.0;
  static const _fabSize = 52.0;

  @override
  Widget build(BuildContext context) {
    
    
    final unselectedColor = _unselectedColor;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _barHeight + _fabRise + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // ── Bar surface ────────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: _barHeight + bottomPadding,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x1A000000),
                    blurRadius: 12,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tab 0 — Home
                  _NavItem(
                    icon: Icons.home,
                    label: 'الرئيسية',
                    index: 0,
                    currentIndex: currentIndex,
                    onTap: onTap,
                    selectedColor: _selectedColor,
                    unselectedColor: _unselectedColor,
                  ),

                  // Tab 1 — My Tickets
                  _NavItem(
                    icon: Icons.description_outlined,
                    label: 'تذكرتي',
                    index: 1,
                    currentIndex: currentIndex,
                    onTap: onTap,
                    selectedColor: _selectedColor,
                    unselectedColor: _unselectedColor,
                  ),

                  // Tab 2 — Centre placeholder (the FAB sits above this slot)
                  // We reserve the same horizontal space so the flanking items
                  // are correctly spread with spaceAround.
                  SizedBox(width: _fabSize),

                  // Tab 3 — Booking
                  _NavItem(
                    icon: Icons.book_online,
                    label: 'حجز',
                    index: 3,
                    currentIndex: currentIndex,
                    onTap: onTap,
                    selectedColor: _selectedColor,
                    unselectedColor: _unselectedColor,
                  ),

                  // Tab 4 — Account
                  _NavItem(
                    icon: Icons.person_2_rounded,
                    label: 'الحساب',
                    index: 4,
                    currentIndex: currentIndex,
                    onTap: onTap,
                    selectedColor: _selectedColor,
                    unselectedColor: unselectedColor,
                  ),
                ],
              ),
            ),
          ),

          // ── Elevated centre FAB (Tab 2 — شراء) ───────────────────────────
          // Floated _fabRise px above the top of the bar surface so it visually
          // protrudes like the original design.
          Positioned(
            bottom: bottomPadding + 12,
            child: _CentreTabFab(
              isSelected: currentIndex == 2,
              onTap: () => onTap(2),
              fabSize: _fabSize,
              selectedColor: _selectedColor,
              unselectedColor: unselectedColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// A regular (non-elevated) navigation item: icon + label.
// ─────────────────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    final color = isSelected ? selectedColor : unselectedColor;

    return InkWell(
      onTap: () => onTap(index),
      splashColor: selectedColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// The elevated circular FAB for the centre "شراء" tab.
///
/// Replicates the original:
///   Transform.translate(offset: Offset(0, -15)) + Container circle +
///   IconButton with confirmation_number icon
// ─────────────────────────────────────────────────────────────────────────────
class _CentreTabFab extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final double fabSize;
  final Color selectedColor;
  final Color unselectedColor;

  const _CentreTabFab({
    required this.isSelected,
    required this.onTap,
    required this.fabSize,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Filled circle with elevation shadow
          Container(
            width: fabSize,
            height: fabSize,
            decoration: BoxDecoration(
              color: selectedColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: selectedColor.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.confirmation_number,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'شراء',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isSelected ? selectedColor : unselectedColor,
            ),
          ),
        ],
      ),
    );
  }
}







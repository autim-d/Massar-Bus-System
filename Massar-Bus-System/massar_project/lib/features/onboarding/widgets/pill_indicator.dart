import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PillIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const PillIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isSelected ? 40 : 24,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : AppColors.indicatorInactive,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}



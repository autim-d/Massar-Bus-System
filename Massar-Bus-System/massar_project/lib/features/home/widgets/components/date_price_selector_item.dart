import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DatePriceSelectorItem extends StatelessWidget {
  final DateTime date;
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  const DatePriceSelectorItem({
    Key? key,
    required this.date,
    required this.price,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dynamic Arabic date formatting mockup
    // Real implementation would use intl package
    final List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    final dayName = weekDays[date.weekday % 7];
    final monthName = months[date.month - 1];
    final dateStr = '$dayName, ${date.day} $monthName ${date.year}';
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.mainButton : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Column(
          children: [
            Text(
              dateStr,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFF1D2939) : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${price.toInt()} ر.ي',
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? AppColors.mainButton : const Color(0xFF1D2939),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class FilterChipRow extends StatelessWidget {
  final List<String> filters;
  final String activeFilter;
  final ValueChanged<String> onFilterSelected;

  const FilterChipRow({
    Key? key,
    required this.filters,
    required this.activeFilter,
    required this.onFilterSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: filters.map((filter) {
          final isSelected = filter == activeFilter;
          return Padding(
            padding: const EdgeInsets.only(left: 8.0), // RTL layout so padding is on the left
            child: GestureDetector(
              onTap: () => onFilterSelected(filter),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1570EF) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF1570EF) : const Color(0xFFE4E7EC),
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF667085),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

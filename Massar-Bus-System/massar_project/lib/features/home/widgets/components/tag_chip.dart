import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const TagChip({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  factory TagChip.fastest() => const TagChip(
        label: 'الأسرع',
        backgroundColor: Color(0xFFE85C0D),
        textColor: Colors.white,
      );

  factory TagChip.cheapest() => const TagChip(
        label: 'الأرخص',
        backgroundColor: Color(0xFF12B76A),
        textColor: Colors.white,
      );

  factory TagChip.menOnly() => const TagChip(
        label: 'رجال فقط',
        backgroundColor: Color(0xFF2E90FA),
        textColor: Colors.white,
      );

  factory TagChip.ladiesOnly() => const TagChip(
        label: 'نساء فقط',
        backgroundColor: Color(0xFFF63D68),
        textColor: Colors.white,
      );
      
  factory TagChip.mixed() => const TagChip(
        label: 'مختلط',
        backgroundColor: Colors.white,
        textColor: Color(0xFF344054),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: label == 'مختلط' ? Border.all(color: const Color(0xFFD0D5DD)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}



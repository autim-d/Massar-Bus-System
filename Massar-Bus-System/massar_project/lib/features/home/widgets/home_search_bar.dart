import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeSearchBar({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : const Color(0xFFE4E7EC),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'أين تريد الذهاب اليوم؟',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 15,
              color: theme.textTheme.bodyMedium?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

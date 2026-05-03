import 'package:flutter/material.dart';

class CheckoutStepper extends StatelessWidget {
  const CheckoutStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "طريقة الدفع",
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          _buildStepCircle(context, "1", isActive: true),
          _buildStepDivider(context),
          Text(
            "ادفع",
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          _buildStepCircle(context, "2"),
          _buildStepDivider(context),
          Text(
            "إنهاء",
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          _buildStepCircle(context, "3"),
        ],
      ),
    );
  }

  Widget _buildStepCircle(BuildContext context, String number, {bool isActive = false}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? (isDark ? Colors.blue.withValues(alpha: 0.2) : const Color(0xffEFF8FF))
            : (isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xffF9FAFB)),
        border: Border.all(
          color: isActive ? Colors.blue : (isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xffD0D5DD)),
          width: 1,
        ),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? Colors.blue : theme.textTheme.bodyMedium?.color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStepDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 2,
      width: 40,
      color: theme.dividerColor,
    );
  }
}

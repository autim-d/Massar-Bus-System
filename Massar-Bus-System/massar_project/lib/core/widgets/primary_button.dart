import 'package:flutter/material.dart';
import '../theme/app_colors.dart';class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final Color color;
  final double height;
  final double borderRadius;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.color = AppColors.primaryBlue,
    this.height = 50,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: color.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

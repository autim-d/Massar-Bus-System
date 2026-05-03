import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextDirection? textDirection;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? enabled;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textDirection,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFD0D5DD) : const Color(0xFF344054),
            ),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          textDirection: textDirection,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          style: TextStyle(
            fontFamily: 'ReadexPro',
            fontSize: 14,
            color: theme.textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'ReadexPro',
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: isDark ? const Color(0xFF1D2939) : Colors.white,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : const Color(0xFFD0D5DD),
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.primaryBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            errorStyle: const TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 12,
              color: Colors.red,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFEAECF0),
                  width: 1),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

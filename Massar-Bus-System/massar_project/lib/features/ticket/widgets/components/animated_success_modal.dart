import 'package:flutter/material.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:intl/intl.dart' as intl;

void showAnimatedSuccessModal({
  required BuildContext context,
  required String title,
  required String orderId,
  required String paymentMethod,
  required DateTime transactionDate,
  required VoidCallback onViewTicket,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Success",
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, a1, a2, child) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: _SuccessModalContent(
            title: title,
            orderId: orderId,
            paymentMethod: paymentMethod,
            transactionDate: transactionDate,
            onViewTicket: onViewTicket,
          ),
        ),
      );
    },
  );
}

class _SuccessModalContent extends StatefulWidget {
  final String title;
  final String orderId;
  final String paymentMethod;
  final DateTime transactionDate;
  final VoidCallback onViewTicket;

  const _SuccessModalContent({
    required this.title,
    required this.orderId,
    required this.paymentMethod,
    required this.transactionDate,
    required this.onViewTicket,
  });

  @override
  State<_SuccessModalContent> createState() => _SuccessModalContentState();
}

class _SuccessModalContentState extends State<_SuccessModalContent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatArabicDateTime(DateTime date) {
    // Basic Arabic date formatting without intl package dependency issues
    const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    final month = months[date.month - 1];
    
    // Convert 24h to 12h AM/PM
    int hour = date.hour;
    String period = 'صباحاً';
    if (hour >= 12) {
      period = 'مساءً';
      if (hour > 12) hour -= 12;
    }
    if (hour == 0) hour = 12;
    
    final minuteStr = date.minute.toString().padLeft(2, '0');
    
    return '${date.day} $month ، ${date.year} الساعة $hour:$minuteStr $period';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: theme.cardTheme.color,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Checkmark
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xff1570EF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  children: [
                    _buildRow(context, 'معرّف الطلب:', widget.orderId),
                    const SizedBox(height: 12),
                    _buildRow(context, 'طريقة الدفع:', widget.paymentMethod),
                    const SizedBox(height: 12),
                    _buildRow(context, 'التاريخ والوقت:', _formatArabicDateTime(widget.transactionDate)),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1570EF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Close the dialog first
                    Navigator.of(context).pop();
                    // Then trigger the view ticket callback
                    widget.onViewTicket();
                  },
                  child: const Text(
                    'عرض التذكرة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 14,
              fontWeight: label == 'التاريخ والوقت:' ? FontWeight.normal : FontWeight.bold,
              color: label == 'التاريخ والوقت:'
                  ? (isDark ? theme.textTheme.bodySmall?.color : Colors.grey.shade700)
                  : theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}

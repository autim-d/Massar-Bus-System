import 'package:flutter/material.dart';

class PriceBreakdownColumn extends StatelessWidget {
  final double ticketPrice;
  final double protectionFee;
  final double serviceFee;

  const PriceBreakdownColumn({
    super.key,
    required this.ticketPrice,
    required this.protectionFee,
    required this.serviceFee,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double totalPrice = ticketPrice + protectionFee + serviceFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "تفاصيل الدفع",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildPriceRow(context, "سعر التذكرة", "${ticketPrice.toInt()} ريال يمني"),
        Divider(height: 15, color: theme.dividerColor),
        _buildPriceRow(context, "الحماية", "${protectionFee.toInt()} ريال يمني"),
        Divider(height: 15, color: theme.dividerColor),
        _buildPriceRow(context, "رسوم الخدمة", "${serviceFee.toInt()} ريال يمني"),
        const SizedBox(height: 10),
        _buildPriceRow(context, "الإجمالي", "${totalPrice.toInt()} ريال يمني", isTotal: true),
      ],
    );
  }

  Widget _buildPriceRow(BuildContext context, String title, String amount, {bool isTotal = false}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isTotal
                  ? theme.textTheme.bodyLarge?.color
                  : (isDark ? theme.textTheme.bodySmall?.color : const Color(0xff667085)),
              fontSize: isTotal ? 17 : 15,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 17 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
              color: isTotal ? const Color(0xff1570EF) : theme.textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

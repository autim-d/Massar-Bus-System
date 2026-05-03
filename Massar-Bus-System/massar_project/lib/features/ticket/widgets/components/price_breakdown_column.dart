import 'package:massar_project/core/theme/app_colors.dart';
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
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildPriceRow(context, "سعر التذكرة", "${ticketPrice.toInt()} ريال يمني"),
        Divider(height: 15, color: AppColors.grey200),
        _buildPriceRow(context, "الحماية", "${protectionFee.toInt()} ريال يمني"),
        Divider(height: 15, color: AppColors.grey200),
        _buildPriceRow(context, "رسوم الخدمة", "${serviceFee.toInt()} ريال يمني"),
        const SizedBox(height: 10),
        _buildPriceRow(context, "الإجمالي", "${totalPrice.toInt()} ريال يمني", isTotal: true),
      ],
    );
  }

  Widget _buildPriceRow(BuildContext context, String title, String amount, {bool isTotal = false}) {
    
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isTotal
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
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
              color: isTotal ? AppColors.mainButton : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}







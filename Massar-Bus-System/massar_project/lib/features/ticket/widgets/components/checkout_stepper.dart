import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CheckoutStepper extends StatelessWidget {
  const CheckoutStepper({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "طريقة الدفع",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          _buildStepCircle(context, "1", isActive: true),
          _buildStepDivider(context),
          Text(
            "ادفع",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          _buildStepCircle(context, "2"),
          _buildStepDivider(context),
          Text(
            "إنهاء",
            style: TextStyle(
              color: AppColors.textSecondary,
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
    
    
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? const Color(0xffEFF8FF) : const Color(0xffF9FAFB),
        border: Border.all(
          color: isActive ? Colors.blue : const Color(0xffD0D5DD),
          width: 1,
        ),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? Colors.blue : AppColors.textSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStepDivider(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 2,
      width: 40,
      color: AppColors.grey200,
    );
  }
}







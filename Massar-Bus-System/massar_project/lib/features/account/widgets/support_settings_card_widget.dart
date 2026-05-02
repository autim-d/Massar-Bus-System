import 'package:flutter/material.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/core/constants/app_strings.dart';

class SupportSettingsCardWidget extends StatelessWidget {
  const SupportSettingsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.iconOf,
          width: 0.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7),
                  Text(
                    ' ${AppStrings.supportHelp} ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(92, 102, 112, 133),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '  ${AppStrings.appExperience} ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 2,
                    color: Color.fromARGB(80, 102, 112, 133),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ' ${AppStrings.settings}  ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

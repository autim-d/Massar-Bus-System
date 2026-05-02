import 'package:flutter/material.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/core/constants/app_strings.dart';
import 'package:massar_project/features/account/screens/profile_screen.dart';

class AccountSettingsCardWidget extends StatelessWidget {
  const AccountSettingsCardWidget({super.key});

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => const Profile(),
                        ),
                      );
                    },
                    child: Text(
                      ' ${AppStrings.myAccount} ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Divider(
                    height: 4,
                    color: Color.fromARGB(94, 102, 112, 133),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    ' ${AppStrings.saveLocation} ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/core/constants/app_strings.dart';

class AccountSettingsCardWidget extends StatelessWidget {
  const AccountSettingsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: theme.dividerColor,
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
                      context.push('/account/profile');
                    },
                    child: Text(
                      ' ${AppStrings.myAccount} ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Divider(
                    height: 4,
                    color: theme.dividerColor,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    ' ${AppStrings.saveLocation} ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.textTheme.bodyLarge?.color,
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

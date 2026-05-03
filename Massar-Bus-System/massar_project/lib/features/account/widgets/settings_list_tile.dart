import 'package:flutter/material.dart';
import 'package:massar_project/core/theme/app_colors.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final VoidCallback onTap;

  const SettingsListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Custom Leading Icon Container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.mainButton.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                leadingIcon,
                color: AppColors.mainButton,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontFamily: 'ReadexPro',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontFamily: 'ReadexPro',
                    ),
                  ),
                ],
              ),
            ),
            
            // Trailing Arrow (automatically flips in RTL)
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF98A2B3),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}







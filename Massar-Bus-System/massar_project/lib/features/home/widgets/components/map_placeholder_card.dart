import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MapPlaceholderCard extends StatelessWidget {
  const MapPlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تتبع الباص',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: 'ReadexPro',
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: const Color(0xFFE4E7EC),
            ),
            // A subtle grey background representing the map
            color: const Color(0xFFF2F4F7),
          ),
          child: Stack(
            children: [
              // Placeholder for a map graphic
              Center(
                child: Opacity(
                  opacity: 0.3,
                  child: Text(
                    'Jakarta\nKampung Bali       Kebon Sirih',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
              // Blue Location Dot
              Positioned(
                bottom: 24,
                left: 48,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainButton.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mainButton,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}







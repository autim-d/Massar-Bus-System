import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LocationInputConnector extends StatelessWidget {
  final TextEditingController originController;
  final TextEditingController destinationController;
  final FocusNode originFocusNode;
  final FocusNode destinationFocusNode;
  final VoidCallback onOriginTap;
  final VoidCallback onDestinationTap;
  final Function(String) onDestinationSubmitted;

  const LocationInputConnector({
    Key? key,
    required this.originController,
    required this.destinationController,
    required this.originFocusNode,
    required this.destinationFocusNode,
    required this.onOriginTap,
    required this.onDestinationTap,
    required this.onDestinationSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE4E7EC),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Origin Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: originController,
                    focusNode: originFocusNode,
                    onTap: onOriginTap,
                    decoration: InputDecoration(
                      hintText: 'موقعك الحالي',
                      hintStyle: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xFF12B76A), // Green
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider & Dotted Line
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFFE4E7EC),
                  margin: const EdgeInsets.only(left: 44),
                ),
              ),
              // Dotted line simulation using small containers
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 2,
                      height: 3,
                      margin: const EdgeInsets.only(bottom: 2),
                      color: const Color(0xFFD0D5DD),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Destination Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: destinationController,
                    focusNode: destinationFocusNode,
                    onTap: onDestinationTap,
                    onSubmitted: onDestinationSubmitted,
                    decoration: InputDecoration(
                      hintText: 'البحث عن وجهة',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE85C0D), // Orange
                      width: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





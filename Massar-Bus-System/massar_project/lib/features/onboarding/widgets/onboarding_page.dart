import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration with circular background
          Stack(
            alignment: Alignment.center,
            children: [
              // Circular background decoration
              Container(
                width: screenWidth * 0.75,
                height: screenWidth * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
              ),
              // The main illustration
              Image.asset(
                imagePath,
                width: screenWidth * 0.65,
                height: screenWidth * 0.65,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const SizedBox(height: 48),
          
          // Text Content
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'ReadexPro',
              fontSize: 16,
              height: 1.5,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

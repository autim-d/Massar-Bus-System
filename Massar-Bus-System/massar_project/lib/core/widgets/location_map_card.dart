import 'package:flutter/material.dart';

class LocationMapCard extends StatelessWidget {
  final String title;
  final String locationDetails;
  final String imagePath;

  const LocationMapCard({
    Key? key,
    required this.title,
    required this.locationDetails,
    this.imagePath = 'assets/images/map.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    const double cardRadius = 14.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(cardRadius),
              topRight: Radius.circular(cardRadius),
            ),
            child: Container(
              height: 120,
              color: Colors.grey.shade100,
              child: Stack(
                children: [
                   Positioned.fill(
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 20,
                    top: 18,
                    child: Container(
                      width: 16, height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E9BFF),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'AirStripArabic', fontSize: w * 0.038, fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  locationDetails,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'AirStripArabic', fontSize: w * 0.032, color: Colors.grey.shade600,
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

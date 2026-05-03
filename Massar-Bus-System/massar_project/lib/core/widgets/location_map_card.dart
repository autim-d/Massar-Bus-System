import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import '../../location_fun.dart';

class LocationMapCard extends StatelessWidget {
  final String title;
  final String? locationDetails;
  final String imagePath;
  final Position? position;
  final String? mapboxPublicToken;
  final bool isLoading;

  const LocationMapCard({
    Key? key,
    required this.title,
    this.locationDetails,
    this.imagePath = 'assets/images/map.png',
    this.position,
    this.mapboxPublicToken,
    this.isLoading = false,
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
            color: Colors.black.withValues(alpha: 0.04),
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
                    child: position != null
                        ? SizedBox(
                            height: 120, // Ensure fixed height for MapWidget
                            child: mapbox.MapWidget(
                              cameraOptions: mapbox.CameraOptions(
                                center: mapbox.Point(
                                  coordinates: mapbox.Position(
                                    position!.longitude,
                                    position!.latitude,
                                  ),
                                ),
                                zoom: 14.0,
                              ),
                            ),
                          )
                        : Image.asset(imagePath, fit: BoxFit.cover),
                  ),


                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.1),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
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
                    fontFamily: 'AirStripArabic',
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  locationDetails ?? "موقع غير معروف",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'AirStripArabic',
                    fontSize: w * 0.032,
                    color: Colors.grey.shade600,
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

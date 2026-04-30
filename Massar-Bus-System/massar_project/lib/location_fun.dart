import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

Future<String> getCurrentNeighborhood(Position position, String mapboxPublicToken) async {
  // Using language=ar ensures the response matches your Arabic UI
  final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/${position.longitude},${position.latitude}.json?language=ar&access_token=$mapboxPublicToken');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'] != null && data['features'].isNotEmpty) {
        // This will return a string similar to "المساكن, المكلا, حضرموت"
        return data['features'][0]['place_name']; 
      }
    }
  } catch (e) {
    print("Geocoding error: $e");
  }
  return "موقع غير معروف"; // Fallback
}
import 'dart:io';

class ApiConstants {
  // TODO: Securely store this token (e.g., using flutter_dotenv or as an environment variable)
  static const String mapboxPublicToken = String.fromEnvironment('MAPBOX_TOKEN', defaultValue: 'YOUR_MAPBOX_TOKEN_HERE');
}


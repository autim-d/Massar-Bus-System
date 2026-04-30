class ApiConstants {
  // Use http://10.0.2.2:8000 for Android Emulator connecting to local Laravel
  // Use http://127.0.0.1:8000 for iOS Simulator
  // Update to your production domain when deploying.
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String mapboxPublicToken = String.fromEnvironment('MAPBOX_PUBLIC_TOKEN', defaultValue: '');
}

import 'dart:io';

class ApiConstants {
  // Uses the real device IP on Android, localhost on iOS
  static final String baseUrl = Platform.isAndroid
      ? 'http://10.128.81.152:8000/api'
      : 'http://127.0.0.1:8000/api';
  static const String mapboxPublicToken = String.fromEnvironment('MAPBOX_PUBLIC_TOKEN', defaultValue: '');
}

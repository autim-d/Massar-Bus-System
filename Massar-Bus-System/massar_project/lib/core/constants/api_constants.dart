import 'dart:io';

class ApiConstants {
  static const String baseUrl = 'http://10.0.0.109:8000/api';
  static const String mapboxPublicToken = String.fromEnvironment('MAPBOX_PUBLIC_TOKEN', defaultValue: '');
}

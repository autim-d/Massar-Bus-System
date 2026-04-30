import 'dart:io';

class ApiConstants {
  static final String baseUrl = Platform.isAndroid
      ? 'http://10.0.0.109:8000/api'
      : 'http://127.0.0.1:8000/api';
}

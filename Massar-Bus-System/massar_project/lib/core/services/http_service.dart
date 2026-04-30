import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/services/auth_service.dart';

// Provides a global Singleton of the HttpService, injecting the AuthService automatically
final httpServiceProvider = Provider<HttpService>((ref) {
  final authService = ref.watch(authServiceProvider);
  return HttpService(authService);
});

class HttpService {
  final AuthService _authService;

  HttpService(this._authService);

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getIdToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String url) async {
    final headers = await _getHeaders();
    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<http.Response> post(String url, {Map<String, dynamic>? body}) async {
    final headers = await _getHeaders();
    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> put(String url, {Map<String, dynamic>? body}) async {
    final headers = await _getHeaders();
    return await http.put(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> delete(String url) async {
    final headers = await _getHeaders();
    return await http.delete(Uri.parse(url), headers: headers);
  }

  // دعم رفع الملفات
  Future<http.Response> multipart(
    String url, {
    required String filePath,
    String fieldName = 'avatar',
    String method = 'POST',
  }) async {
    final token = await _authService.getIdToken();
    final request = http.MultipartRequest(method, Uri.parse(url));

    request.headers.addAll({
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    });

    request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}

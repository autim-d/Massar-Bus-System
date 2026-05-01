import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/constants/api_constants.dart';
import 'package:massar_project/core/services/http_service.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return BookingRepository(httpService);
});

class BookingRepository {
  final HttpService _http;

  BookingRepository(this._http);

  /// إنشاء حجز جديد (حجز مؤقت أو بانتظار الدفع)
  Future<Map<String, dynamic>> createBooking(String tripId, {String? passengerName, String? passengerPhone}) async {
    try {
      final response = await _http.post(
        '${ApiConstants.baseUrl}/bookings',
        body: {
          'trip_id': tripId,
          'passenger_name': passengerName,
          'passenger_phone': passengerPhone,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'booking': data['data'] ?? data,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'فشل إنشاء الحجز',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'خطأ في الاتصال بالسيرفر',
      };
    }
  }

  /// جلب قائمة حجوزات المستخدم
  Future<List<dynamic>> getBookings() async {
    final response = await _http.get('${ApiConstants.baseUrl}/bookings');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['data'] ?? [];
    } else {
      throw Exception('فشل تحميل الحجوزات');
    }
  }
}

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/constants/api_constants.dart';
import 'package:massar_project/core/services/http_service.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return PaymentRepository(httpService);
});

class PaymentRepository {
  final HttpService _http;

  PaymentRepository(this._http);

  /// إنشاء نية دفع (Payment Intent) في Stripe عبر الباك أند
  Future<Map<String, dynamic>> createPaymentIntent(int bookingId) async {
    try {
      final response = await _http.post(
        '${ApiConstants.baseUrl}/payments/intent',
        body: {'booking_id': bookingId},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'client_secret': data['client_secret'],
          'payment_intent_id': data['payment_intent_id'],
        };
      } else {
        return {
          'success': false,
          'message': data['error'] ?? 'فشل إنشاء عملية الدفع',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'خطأ في الاتصال بسيرفر الدفع',
      };
    }
  }

  /// تأكيد الدفع بعد نجاحه في Stripe
  Future<Map<String, dynamic>> confirmPayment(int bookingId, String paymentIntentId) async {
    try {
      final response = await _http.post(
        '${ApiConstants.baseUrl}/payments/confirm',
        body: {
          'booking_id': bookingId,
          'payment_intent_id': paymentIntentId,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'تم تأكيد الدفع بنجاح',
          'booking': data['booking'],
        };
      } else {
        return {
          'success': false,
          'message': data['error'] ?? 'فشل تأكيد الدفع',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'خطأ في الاتصال بالسيرفر أثناء تأكيد الدفع',
      };
    }
  }
}

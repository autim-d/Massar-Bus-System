import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository(Supabase.instance.client);
});

class PaymentRepository {
  final SupabaseClient _supabase;

  PaymentRepository(this._supabase);

  /// إنشاء نية دفع (Payment Intent) في Stripe عبر Supabase Edge Functions
  Future<Map<String, dynamic>> createPaymentIntent(int bookingId) async {
    try {
      final response = await _supabase.functions.invoke(
        'create-payment-intent',
        body: {'booking_id': bookingId},
      );

      final data = response.data;

      if (response.status == 200) {
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
        'message': 'خطأ في الاتصال بسيرفر الدفع: $e',
      };
    }
  }

  /// تأكيد الدفع بعد نجاحه في Stripe
  Future<Map<String, dynamic>> confirmPayment(int bookingId, String paymentIntentId) async {
    try {
      final response = await _supabase.functions.invoke(
        'confirm-payment',
        body: {
          'booking_id': bookingId,
          'payment_intent_id': paymentIntentId,
        },
      );

      final data = response.data;

      if (response.status == 200) {
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
        'message': 'خطأ أثناء تأكيد الدفع: $e',
      };
    }
  }
}

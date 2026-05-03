import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepository(Supabase.instance.client);
});

class BookingRepository {
  final SupabaseClient _supabase;

  BookingRepository(this._supabase);

  /// إنشاء حجز جديد
  Future<Map<String, dynamic>> createBooking(String tripId, {String? passengerName, String? passengerPhone}) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      // Fetch user id from our internal users table
      final user = await _supabase.from('users').select('id').eq('firebase_uid', userId).single();

      // Insert booking via Supabase. Note: business logic like generating booking code 
      // or fetching ticket price should be handled either here, or better, in a Postgres trigger.
      final response = await _supabase.from('bookings').insert({
        'user_id': user['id'],
        'trip_id': int.parse(tripId),
        'passenger_name': passengerName,
        'passenger_phone': passengerPhone,
        'status': 'pending',
      }).select().single();

      return {
        'success': true,
        'booking': response,
      };
    } on PostgrestException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطأ في الاتصال بالسيرفر: $e',
      };
    }
  }

  /// جلب قائمة حجوزات المستخدم
  Future<List<dynamic>> getBookings() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('Not authenticated');

      final user = await _supabase.from('users').select('id').eq('firebase_uid', userId).single();
      
      final response = await _supabase
          .from('bookings')
          .select('*, trips(*, routes(*, stations(*)), buses(*))')
          .eq('user_id', user['id']);
          
      return response;
    } catch (e) {
      throw Exception('فشل تحميل الحجوزات: $e');
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// مزود لجلب آخر تذكرة نشطة للمستخدم من Supabase
final activeTicketProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final supabase = Supabase.instance.client;

  try {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return null;

    // 1. Get internal user id
    final user = await supabase.from('users').select('id').eq('firebase_uid', userId).single();

    // 2. Fetch latest paid booking
    final booking = await supabase
        .from('bookings')
        .select('*, trip:trips(*, route:routes(*, origin:stations!origin_station_id(*), destination:stations!destination_station_id(*)), bus:buses(*))')
        .eq('user_id', user['id'])
        .eq('status', 'paid') 
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (booking == null) return null;

    final trip = booking['trip'] ?? {};
    final route = trip['route'] ?? {};
    final origin = route['origin'] ?? {};
    final destination = route['destination'] ?? {};
    final bus = trip['bus'] ?? {};

    // Calculate duration text
    final minutes = route['estimated_duration_minutes'] ?? 0;
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    final durationText = hours > 0 
        ? '$hours ساعة ${remainingMinutes > 0 ? 'و$remainingMinutes دقيقة' : ''}'
        : '$remainingMinutes دقيقة';

    return {
      'booking_code': booking['booking_code'] ?? 'N/A',
      'date': (trip['departure_time'] as String?)?.split(' ').first ?? '---',
      'from': origin['name'] ?? '---',
      'to': destination['name'] ?? '---',
      'duration': durationText,
      'bus_info':
          '${bus['bus_name'] ?? 'باص'} الوصول الساعة ${(trip['arrival_time'] as String?)?.split(' ').last.substring(0, 5) ?? '--:--'} في المحطة',
    };
  } catch (e) {
    print('Active Ticket Error: $e');
    return null;
  }
});

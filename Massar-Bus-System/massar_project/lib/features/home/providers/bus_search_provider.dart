import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/bus_ticket_model.dart';
import '../models/bus_search_criteria.dart';
import '../models/location_model.dart';

final busSearchProvider = FutureProvider.family<List<BusTicketModel>, BusSearchCriteria>((
  ref,
  criteria,
) async {
  final supabase = Supabase.instance.client;

  final String formattedDate =
      "${criteria.date.year}-${criteria.date.month.toString().padLeft(2, '0')}-${criteria.date.day.toString().padLeft(2, '0')}";

  try {
    // 1. Build query
    var query = supabase
        .from('trips')
        .select('*, route:routes!inner(*, origin:stations!origin_station_id(*), destination:stations!destination_station_id(*)), bus:buses(*)');

    // 2. Add filters
    query = query
        .gte('departure_time', '$formattedDate 00:00:00')
        .lte('departure_time', '$formattedDate 23:59:59');

    if (criteria.fromId != null && criteria.fromId!.isNotEmpty) {
      query = query.eq('route.origin_station_id', int.parse(criteria.fromId!));
    }
    if (criteria.toId != null && criteria.toId!.isNotEmpty) {
      query = query.eq('route.destination_station_id', int.parse(criteria.toId!));
    }

    final response = await query;

    // 3. Map to Model
    return (response as List).map((json) {
      final route = json['route'] ?? {};
      final bus = json['bus'] ?? {};
      final origin = route['origin'] ?? {};
      final destination = route['destination'] ?? {};

      // Calculate duration text from minutes
      final minutes = route['estimated_duration_minutes'] ?? 0;
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      final durationText = hours > 0 
          ? '$hours ساعة ${remainingMinutes > 0 ? 'و$remainingMinutes دقيقة' : ''}'
          : '$remainingMinutes دقيقة';

      return BusTicketModel(
        id: json['id'].toString(),
        busName: bus['bus_name'] ?? 'باص ماسار',
        date: DateTime.parse(json['departure_time']),
        departureTime: (json['departure_time'] as String).split(' ').last.substring(0, 5),
        arrivalTime: (json['arrival_time'] as String).split(' ').last.substring(0, 5),
        fromStation: LocationModel(id: origin['id'].toString(), name: origin['name'] ?? ''),
        toStation: LocationModel(id: destination['id'].toString(), name: destination['name'] ?? ''),
        durationText: durationText,
        price: 50.0, // Assuming a default price or you can add a price column to trips/routes
      );
    }).toList();
  } catch (e) {
    print('Search Error: $e');
    throw Exception('فشل الاتصال بالخادم أو لا توجد بيانات متاحة.');
  }
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/models/station_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final stationRepositoryProvider = Provider<StationRepository>((ref) {
  return StationRepository(Supabase.instance.client);
});

class StationRepository {
  final SupabaseClient _supabase;

  StationRepository(this._supabase);

  Future<List<StationModel>> getStations() async {
    try {
      final response = await _supabase.from('stations').select();
      return response.map((item) => StationModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load stations: $e');
    }
  }
}

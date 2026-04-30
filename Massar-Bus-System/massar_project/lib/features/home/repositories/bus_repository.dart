import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/services/http_service.dart';
import '../models/bus_ticket_model.dart';

final busRepositoryProvider = Provider<BusRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return BusRepository(httpService);
});

class BusRepository {
  final HttpService _httpService;

  BusRepository(this._httpService);

  Future<List<BusTicketModel>> fetchAvailableBuses() async {
    try {
      final response = await _httpService.get('/trips');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'] ?? [];
        return data.map((json) => BusTicketModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load trips: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

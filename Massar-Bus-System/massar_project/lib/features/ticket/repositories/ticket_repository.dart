import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/services/http_service.dart';
import '../models/ticket_status_model.dart';

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return TicketRepository(httpService);
});

class TicketRepository {
  final HttpService _httpService;

  TicketRepository(this._httpService);

  Future<List<TicketStatusModel>> fetchActiveTickets() async {
    try {
      final response = await _httpService.get('/bookings');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'] ?? [];
        return data.map((json) => TicketStatusModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tickets: ${response.statusCode}');
      }
    } catch (e) {
      // Allow exceptions (like TimeoutException) to bubble up or log them
      rethrow;
    }
  }
}

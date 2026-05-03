import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/constants/api_constants.dart';
import 'package:massar_project/core/models/station_model.dart';
import 'package:massar_project/core/services/http_service.dart';

final stationRepositoryProvider = Provider<StationRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return StationRepository(httpService);
});

class StationRepository {
  final HttpService _http;

  StationRepository(this._http);

  Future<List<StationModel>> getStations() async {
    final response = await _http.get('${ApiConstants.baseUrl}/stations');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((item) => StationModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load stations: ${response.statusCode}');
    }
  }
}


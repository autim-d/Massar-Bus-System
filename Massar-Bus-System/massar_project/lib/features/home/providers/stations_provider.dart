import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/repositories/station_repository.dart';
import 'package:massar_project/core/models/station_model.dart';

final stationsProvider = FutureProvider<List<StationModel>>((ref) async {
  final repository = ref.watch(stationRepositoryProvider);
  return await repository.getStations();
});

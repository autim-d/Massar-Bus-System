import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/models/station_model.dart';
import 'package:massar_project/core/repositories/station_repository.dart';

// Provides an asynchronous, cached list of stations 
final stationProvider = FutureProvider<List<StationModel>>((ref) async {
  final repository = ref.watch(stationRepositoryProvider);
  return repository.getStations();
});

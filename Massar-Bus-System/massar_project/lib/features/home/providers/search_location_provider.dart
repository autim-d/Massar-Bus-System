import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/location_model.dart';

class SearchLocationState {
  final LocationModel? currentLocation;
  final LocationModel? destination;

  SearchLocationState({
    this.currentLocation,
    this.destination,
  });

  SearchLocationState copyWith({
    LocationModel? currentLocation,
    LocationModel? destination,
  }) {
    return SearchLocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      destination: destination ?? this.destination,
    );
  }
}

class SearchLocationNotifier extends StateNotifier<SearchLocationState> {
  SearchLocationNotifier() : super(SearchLocationState());

  void updateCurrentLocation(LocationModel location) {
    state = state.copyWith(currentLocation: location);
  }

  void updateDestination(LocationModel location) {
    state = state.copyWith(destination: location);
  }
  
  void swapLocations() {
    state = SearchLocationState(
      currentLocation: state.destination,
      destination: state.currentLocation,
    );
  }
}

final searchLocationProvider = StateNotifierProvider<SearchLocationNotifier, SearchLocationState>((ref) {
  return SearchLocationNotifier();
});



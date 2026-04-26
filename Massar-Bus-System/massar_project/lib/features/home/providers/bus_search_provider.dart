import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bus_ticket_model.dart';
import '../models/location_model.dart';

// Provides mock data based on the current date for the UI
final busSearchProvider = FutureProvider<List<BusTicketModel>>((ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 1));

  final today = DateTime.now();

  return [
    BusTicketModel(
      id: '1',
      busName: 'باص 01',
      date: today,
      departureTime: '15:00', // Mock actual departure
      arrivalTime: '03:45 PM', // Matches UI Mockup arrival text format
      fromStation: LocationModel(id: 'l1', name: 'K. Bali', description: 'محطة'),
      toStation: LocationModel(id: 'l2', name: 'Senen', description: 'محطة'),
      durationText: 'المدة: 30 دقيقة',
      price: 10000,
      isFastest: true,
      isMixed: true,
    ),
    BusTicketModel(
      id: '2',
      busName: 'باص 21',
      date: today,
      departureTime: '15:30',
      arrivalTime: '04:00 PM',
      fromStation: LocationModel(id: 'l1', name: 'K. Bali', description: 'محطة'),
      toStation: LocationModel(id: 'l2', name: 'Senen', description: 'محطة'),
      durationText: 'المدة: 30 دقيقة',
      price: 10000,
      isCheapest: true,
      isMenOnly: true,
    ),
    BusTicketModel(
      id: '3',
      busName: 'باص 03',
      date: today,
      departureTime: '15:45',
      arrivalTime: '04:15 PM',
      fromStation: LocationModel(id: 'l1', name: 'K. Bali', description: 'محطة'),
      toStation: LocationModel(id: 'l2', name: 'Senen', description: 'محطة'),
      durationText: 'المدة: 30 دقيقة',
      price: 10000,
      isFastest: true,
      isLadiesOnly: true,
    ),
  ];
});

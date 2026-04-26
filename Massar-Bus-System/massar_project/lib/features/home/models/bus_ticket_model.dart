import 'location_model.dart';

class BusTicketModel {
  final String id;
  final String busName;
  final DateTime date;
  final String departureTime;
  final String arrivalTime;
  final LocationModel fromStation;
  final LocationModel toStation;
  final String durationText;
  final double price;
  final bool isFastest;
  final bool isCheapest;
  final bool isMenOnly;
  final bool isLadiesOnly;
  final bool isMixed;

  BusTicketModel({
    required this.id,
    required this.busName,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
    required this.fromStation,
    required this.toStation,
    required this.durationText,
    required this.price,
    this.isFastest = false,
    this.isCheapest = false,
    this.isMenOnly = false,
    this.isLadiesOnly = false,
    this.isMixed = false,
  });
}

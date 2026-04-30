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
  final String? passengerName;
  final String? passengerPhone;

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
    this.passengerName,
    this.passengerPhone,
  });

  factory BusTicketModel.fromJson(Map<String, dynamic> json) {
    return BusTicketModel(
      id: json['id']?.toString() ?? '',
      busName: json['busName'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      departureTime: json['departureTime'] ?? '',
      arrivalTime: json['arrivalTime'] ?? '',
      fromStation: LocationModel.fromJson(json['fromStation'] ?? {}),
      toStation: LocationModel.fromJson(json['toStation'] ?? {}),
      durationText: json['durationText'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      isFastest: json['isFastest'] ?? false,
      isCheapest: json['isCheapest'] ?? false,
      isMenOnly: json['isMenOnly'] ?? false,
      isLadiesOnly: json['isLadiesOnly'] ?? false,
      isMixed: json['isMixed'] ?? false,
    );
  }

  BusTicketModel copyWith({
    String? passengerName,
    String? passengerPhone,
  }) {
    return BusTicketModel(
      id: id,
      busName: busName,
      date: date,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
      fromStation: fromStation,
      toStation: toStation,
      durationText: durationText,
      price: price,
      isFastest: isFastest,
      isCheapest: isCheapest,
      isMenOnly: isMenOnly,
      isLadiesOnly: isLadiesOnly,
      isMixed: isMixed,
      passengerName: passengerName ?? this.passengerName,
      passengerPhone: passengerPhone ?? this.passengerPhone,
    );
  }
}

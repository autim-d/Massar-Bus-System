class TripModel {
  final String id;
  final String busName;
  final String date;
  final String departureTime;
  final String arrivalTime;
  final String from;
  final String to;
  final double price;
  final String type; // e.g., 'مختلط', 'عائلي'
  final bool isFastest;
  final bool isCheapest;
  final String? passengerName;
  final String? passengerPhone;

  TripModel({
    required this.id,
    required this.busName,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
    required this.from,
    required this.to,
    required this.price,
    this.type = 'مختلط',
    this.isFastest = false,
    this.isCheapest = false,
    this.passengerName,
    this.passengerPhone,
  });

  /// Factory لتحويل بيانات API (TripResource) إلى TripModel
  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id']?.toString() ?? '',
      busName: json['busName'] ?? 'باص مسار',
      date: json['date'] ?? '',
      departureTime: json['departureTime'] ?? '',
      arrivalTime: json['arrivalTime'] ?? '',
      from: json['fromStation']?['name'] ?? '',
      to: json['toStation']?['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      type: (json['isMixed'] == true)
          ? 'مختلط'
          : (json['isLadiesOnly'] == true)
              ? 'عائلي'
              : (json['isMenOnly'] == true)
                  ? 'رجال فقط'
                  : 'مختلط',
      isFastest: json['isFastest'] ?? false,
      isCheapest: json['isCheapest'] ?? false,
    );
  }

  /// Factory لبيانات عرض تجريبي (يمكن إزالته لاحقاً)
  factory TripModel.sample() {
    return TripModel(
      id: 'TRP-101',
      busName: 'باص النخبة 01',
      date: 'الاثنين، 18 سبتمبر 2025',
      departureTime: '10:00 ص',
      arrivalTime: '03:30 م',
      from: 'المساكن',
      to: 'الشرج',
      price: 10000,
      type: 'مختلط',
      isFastest: true,
    );
  }

  TripModel copyWith({
    String? passengerName,
    String? passengerPhone,
  }) {
    return TripModel(
      id: id,
      busName: busName,
      date: date,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
      from: from,
      to: to,
      price: price,
      type: type,
      isFastest: isFastest,
      isCheapest: isCheapest,
      passengerName: passengerName ?? this.passengerName,
      passengerPhone: passengerPhone ?? this.passengerPhone,
    );
  }
}



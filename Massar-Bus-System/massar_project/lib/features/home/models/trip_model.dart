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
  });

  // Dummy helper to generate a sample trip
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
}

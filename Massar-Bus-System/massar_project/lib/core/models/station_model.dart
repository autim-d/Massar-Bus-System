class StationModel {
  final int id;
  final String name;
  final String city;
  final double latitude;
  final double longitude;

  StationModel({
    required this.id,
    required this.name,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      // We parse as double safely in case JSON returns an integer literal
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}


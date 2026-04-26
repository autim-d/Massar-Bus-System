class LocationModel {
  final String id;
  final String name;
  final String? description;

  LocationModel({
    required this.id,
    required this.name,
    this.description,
  });

  // Example factory for future API integration
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }
}

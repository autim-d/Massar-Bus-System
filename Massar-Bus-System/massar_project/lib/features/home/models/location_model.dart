class LocationModel {
  final String id;
  final String name;
  final String? description;

  LocationModel({
    required this.id,
    required this.name,
    this.description,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      // يأتي id من Laravel كـ int أو String، نحوّله دائماً لـ String
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
    );
  }
}

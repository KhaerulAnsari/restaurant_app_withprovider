class RestaurantModel {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  RestaurantModel({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pictureId: json['pictureId'] ?? '',
      city: json['city'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };
}

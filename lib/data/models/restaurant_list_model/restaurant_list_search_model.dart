import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';

class RestaurantListSearchModel {
  final bool error;
  final int founded;
  final List<RestaurantModel> restaurants;

  RestaurantListSearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantListSearchModel.fromJson(Map<String, dynamic> json) {
    return RestaurantListSearchModel(
      error: json['error'],
      founded: json['founded'],
      restaurants: List<RestaurantModel>.from(
        json['restaurants'].map(
          (restaurant) => RestaurantModel.fromJson(restaurant),
        ),
      ),
    );
  }
}

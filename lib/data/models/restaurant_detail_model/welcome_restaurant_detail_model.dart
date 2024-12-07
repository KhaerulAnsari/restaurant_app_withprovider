import 'package:restaurant_app/data/models/restaurant_detail_model/restaurant_detail_model.dart';

class WelcomeRestaurantDetailModel {
  final bool error;
  final String message;
  final RestaurantDetailModel restaurant;

  WelcomeRestaurantDetailModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory WelcomeRestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    return WelcomeRestaurantDetailModel(
      error: json['error'],
      message: json['message'],
      restaurant: RestaurantDetailModel.fromJson(json['restaurant']),
    );
  }
}

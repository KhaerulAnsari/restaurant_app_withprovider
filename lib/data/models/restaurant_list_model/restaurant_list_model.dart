import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';

class RestaurantListModel {
  final bool? error;
  final String? message;
  final int? count;
  final List<RestaurantModel>? restaurnts;

  RestaurantListModel({
    this.error,
    this.message,
    this.count,
    this.restaurnts,
  });

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) {
    return RestaurantListModel(
        error: json['error'] ?? '',
        message: json['message'] ?? '',
        count: json['count'] ?? 0,
        restaurnts: List<RestaurantModel>.from(json['restaurants']!
                .map((restaurant) => RestaurantModel.fromJson(restaurant)) ??
            <RestaurantModel>[]));
  }
}

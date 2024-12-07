import 'package:restaurant_app/data/models/restaurant_detail_model/category_model.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model/customer_reviews_model.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model/menu_model.dart';

class RestaurantDetailModel {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<CategoryModel> categorys;
  final MenuModel menus;
  final double rating;
  final List<CustomerReviewsModel> customerReviews;

  RestaurantDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categorys,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categorys: List<CategoryModel>.from(
        json['categories'].map(
          (category) => CategoryModel.fromJson(category),
        ),
      ),
      menus: MenuModel.fromJson(json["menus"]),
      rating: json['rating']?.toDouble(),
      customerReviews: List<CustomerReviewsModel>.from(
        json['customerReviews'].map(
          (review) => CustomerReviewsModel.fromJson(review),
        ),
      ),
    );
  }
}

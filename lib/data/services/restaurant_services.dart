import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant_detail_model/welcome_restaurant_detail_model.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_list_model.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_list_search_model.dart';
import 'package:restaurant_app/data/models/restaurant_review_model/review_list_model.dart';
import 'package:restaurant_app/data/models/restaurant_review_model/review_request_model.dart';

class RestaurantServices {
  static const _baseUrl = 'https://restaurant-api.dicoding.dev';

  final http.Client client;
  RestaurantServices({http.Client? client}) : client = client ?? http.Client();

  Future<RestaurantListModel> getListRestaurant() async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/list'),
      );

      if (response.statusCode == 200) {
        return RestaurantListModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat list restaurant.');
      }
    } catch (error) {
      throw Exception("Error : $error");
    }
  }

  Future<WelcomeRestaurantDetailModel> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

      if (response.statusCode == 200) {
        return WelcomeRestaurantDetailModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat detail restaurant.');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<ReviewListModel> addReview(ReviewRequestModel review) async {
    try {
      final response = await http.post(
        headers: {
          'Content-Type': 'application/json',
        },
        Uri.parse('$_baseUrl/review'),
        body: jsonEncode(
          review.toJson(),
        ),
      );

      if (response.statusCode == 201) {
        return ReviewListModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw 'Gagal menambahkan review.';
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<RestaurantListSearchModel> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

      if (response.statusCode == 200) {
        return RestaurantListSearchModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Gagal memuat search restaurant");
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';
import 'package:restaurant_app/data/services/local_database_service.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<RestaurantModel>? _restaurantList;
  List<RestaurantModel>? get restaurantList => _restaurantList;

  RestaurantModel? _restaurant;
  RestaurantModel? get restaurant => _restaurant;

  Future<void> saveRestaurant(RestaurantModel restaurant) async {
    try {
      final result = await _service.insertItem(restaurant);

      final isError = result == 0;

      if (isError) {
        _message = "Failed to save your data";
      } else {
        _message = "Your data is saved";
      }
    } catch (error) {
      _message = "Failed to save your data $error";
    }
    notifyListeners();
  }

  Future<void> loadAllRestaurant() async {
    try {
      _restaurantList = await _service.getAllItems();
      _restaurant = null;
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (error) {
      _message = "Failed to load all data $error";
      notifyListeners();
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItembyId(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (error) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _service.removeItem(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch (error) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  bool checkItemFavorite(String id) {
    final isSameFavorite = _restaurant?.id == id;

    return isSameFavorite;
  }
}

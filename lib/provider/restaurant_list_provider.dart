import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/data/static/restaurant_list_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantServices _restaurantServices;

  RestaurantListProvider(
    this._restaurantServices,
  );

  RestaurantListState _resultState = RestaurantListNoneState();

  RestaurantListState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _restaurantServices.getListRestaurant();

      if (result.error!) {
        _resultState = RestaurantListFailureState(result.message!);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurnts!);
        notifyListeners();
      }
    } on Exception catch (error) {
      _resultState = RestaurantListFailureState(error.toString());

      notifyListeners();
    }
  }

  Future<RestaurantModel> fetchRandomRestaurant() async {
    try {
      final listRestaurant = await _restaurantServices.getListRestaurant();

      if (listRestaurant.restaurnts!.isNotEmpty) {
        final randomRestaurant = listRestaurant
            .restaurnts![Random().nextInt(listRestaurant.restaurnts!.length)];

        return randomRestaurant;
      } else {
        return RestaurantModel();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

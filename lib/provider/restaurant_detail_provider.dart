import 'package:flutter/material.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/data/static/restaurant_detail_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantServices _restaurantServices;

  RestaurantDetailProvider(this._restaurantServices);

  RestaurantDetailState _resultState = RestaurantDetailNoneState();

  RestaurantDetailState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _restaurantServices.getDetailRestaurant(id);

      if (result.error) {
        _resultState = RestaurantDetailFailureState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (error) {
      _resultState = RestaurantDetailFailureState(error.toString());
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/data/static/restaurant_list_search_state.dart';

class RestaurantListSearchProvider extends ChangeNotifier {
  final RestaurantServices _restaurantServices;

  RestaurantListSearchProvider(this._restaurantServices);

  RestaurantListSearchState _resultState = RestaurantListSearchNoneState();

  RestaurantListSearchState get resultState => _resultState;

  Future<void> searchRestaurantList(String query) async {
    try {
      _resultState = RestaurantListSearchLoadingState();
      notifyListeners();

      final result = await _restaurantServices.searchRestaurant(query);

      if (result.error) {
        _resultState =
            RestaurantListSearchFailureState('Gagal mengambil response');
        notifyListeners();
      } else {
        _resultState = RestaurantListSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (error) {
      _resultState = RestaurantListSearchFailureState(error.toString());
      notifyListeners();
    }
  }

  void resetState() {
    _resultState = RestaurantListSearchNoneState();
    notifyListeners();
  }
}

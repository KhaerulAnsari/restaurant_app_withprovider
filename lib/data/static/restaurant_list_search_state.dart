import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';

class RestaurantListSearchState {}

class RestaurantListSearchNoneState extends RestaurantListSearchState {}

class RestaurantListSearchLoadingState extends RestaurantListSearchState {}

class RestaurantListSearchFailureState extends RestaurantListSearchState {
  final String message;

  RestaurantListSearchFailureState(this.message);
}

class RestaurantListSearchLoadedState extends RestaurantListSearchState {
  List<RestaurantModel> restaurants;

  RestaurantListSearchLoadedState(this.restaurants);
}

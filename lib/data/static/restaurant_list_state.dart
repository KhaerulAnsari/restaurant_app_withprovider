import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';

sealed class RestaurantListState {}

class RestaurantListNoneState extends RestaurantListState {}

class RestaurantListLoadingState extends RestaurantListState {}

class RestaurantListFailureState extends RestaurantListState {
  final String message;

  RestaurantListFailureState(this.message);
}

class RestaurantListLoadedState extends RestaurantListState {
  final List<RestaurantModel> data;

  RestaurantListLoadedState(this.data);
}

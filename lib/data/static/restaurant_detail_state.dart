import 'package:restaurant_app/data/models/restaurant_detail_model/restaurant_detail_model.dart';

class RestaurantDetailState {}

class RestaurantDetailNoneState extends RestaurantDetailState {}

class RestaurantDetailLoadingState extends RestaurantDetailState {}

class RestaurantDetailFailureState extends RestaurantDetailState {
  final String message;

  RestaurantDetailFailureState(this.message);
}

class RestaurantDetailLoadedState extends RestaurantDetailState {
  final RestaurantDetailModel restaurantDetail;

  RestaurantDetailLoadedState(this.restaurantDetail);
}

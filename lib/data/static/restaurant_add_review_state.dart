import 'package:restaurant_app/data/models/restaurant_detail_model/customer_reviews_model.dart';

class RestaurantAddReviewState {}

class RestaurantAddReviewNoneState extends RestaurantAddReviewState {}

class RestaurantAddReviewLoadingState extends RestaurantAddReviewState {}

class RestaurantAddReviewFailureState extends RestaurantAddReviewState {
  final String message;

  RestaurantAddReviewFailureState(this.message);
}

class RestaurantAddReviewLoadedState extends RestaurantAddReviewState {
  List<CustomerReviewsModel> reviews;

  RestaurantAddReviewLoadedState(this.reviews);
}

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_review_model/review_request_model.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/data/static/restaurant_add_review_state.dart';

class RestaurantAddReviewProvider extends ChangeNotifier {
  final RestaurantServices _restaurantServices;

  RestaurantAddReviewProvider(this._restaurantServices);

  RestaurantAddReviewState _resultState = RestaurantAddReviewNoneState();

  RestaurantAddReviewState get resultState => _resultState;

  Future<void> addReviews(ReviewRequestModel review) async {
    try {
      _resultState = RestaurantAddReviewLoadingState();
      notifyListeners();

      final result = await _restaurantServices.addReview(review);

      if (result.error) {
        _resultState = RestaurantAddReviewFailureState(result.message);
      } else {
        _resultState = RestaurantAddReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (error) {
      _resultState = RestaurantAddReviewFailureState(error.toString());
      notifyListeners();
    }
  }

  void resetState() {
    _resultState = RestaurantAddReviewNoneState();
    notifyListeners();
  }
}

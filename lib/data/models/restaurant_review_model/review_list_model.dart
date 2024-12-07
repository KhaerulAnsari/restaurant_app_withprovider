import 'package:restaurant_app/data/models/restaurant_detail_model/customer_reviews_model.dart';

class ReviewListModel {
  final bool error;
  final String message;
  final List<CustomerReviewsModel> customerReviews;

  ReviewListModel({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ReviewListModel.fromJson(Map<String, dynamic> json) {
    return ReviewListModel(
      error: json['error'],
      message: json['message'],
      customerReviews: List<CustomerReviewsModel>.from(
        json['customerReviews'].map(
          (review) => CustomerReviewsModel.fromJson(review),
        ),
      ),
    );
  }
}

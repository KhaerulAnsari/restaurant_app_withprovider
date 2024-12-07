class CustomerReviewsModel {
  final String? name;
  final String? review;
  final String? date;

  CustomerReviewsModel({this.name, this.review, this.date});

  factory CustomerReviewsModel.fromJson(Map<String, dynamic> json) {
    return CustomerReviewsModel(
      name: json['name'] ?? '',
      review: json['review'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

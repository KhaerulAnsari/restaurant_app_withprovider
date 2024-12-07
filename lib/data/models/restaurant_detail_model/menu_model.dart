import 'package:restaurant_app/data/models/restaurant_detail_model/category_model.dart';

class MenuModel {
  final List<CategoryModel> foods;
  final List<CategoryModel> drinks;

  MenuModel({
    required this.foods,
    required this.drinks,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      foods: List<CategoryModel>.from(
        json['foods'].map(
          (food) => CategoryModel.fromJson(food),
        ),
      ),
      drinks: List<CategoryModel>.from(
        json['drinks'].map(
          (drink) => CategoryModel.fromJson(drink),
        ),
      ),
    );
  }
}

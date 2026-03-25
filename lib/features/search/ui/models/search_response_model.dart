import 'package:food_app/features/search/ui/models/meal_model.dart';

class SearchResponseModel {
  final List<MealModel>? meals;

  SearchResponseModel({this.meals});

  factory SearchResponseModel.fromJson(
      Map<String, dynamic> json) {
    return SearchResponseModel(
      meals: json['meals'] != null
          ? List<MealModel>.from(
        json['meals'].map(
              (x) => MealModel.fromJson(x),
        ),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals?.map((e) => e.toJson()).toList(),
    };
  }
}
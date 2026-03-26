import '../models/meal_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<MealModel> meals;

  final List<MealModel> searchHistory;
  final List<MealModel> lastViewed;

  SearchSuccessState({
  required this.meals,
  required this.searchHistory,
  required this.lastViewed,
  });

}

class SearchErrorState extends SearchStates {
  final String error;

  SearchErrorState(this.error);
}
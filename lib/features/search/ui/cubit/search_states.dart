import '../models/meal_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<MealModel> meals;

  SearchSuccessState(this.meals);
}

class SearchErrorState extends SearchStates {
  final String error;

  SearchErrorState(this.error);
}
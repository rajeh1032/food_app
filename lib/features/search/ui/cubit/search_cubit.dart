import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/meal_model.dart';
import '../respository/search_repository.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  final SearchRepository repository = SearchRepository();

  List<MealModel> meals = [];

  List<MealModel> searchHistory = [];

  List<MealModel> lastViewed = [];

  Future<void> searchMeals(String query) async {
    if (query.isEmpty) return;

    emit(SearchLoadingState());

    try {
      meals = await repository.searchMeals(query);
      emit(SearchSuccessState(meals));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  void addToLastViewed(MealModel meal) {
    lastViewed.removeWhere((m) => m.idMeal == meal.idMeal);
    lastViewed.insert(0, meal);

    emit(SearchSuccessState(meals));
  }

  void addToSearchHistory(MealModel meal) {
    searchHistory.removeWhere((m) => m.idMeal == meal.idMeal);
    searchHistory.insert(0, meal);

    emit(SearchSuccessState(meals));
  }
}
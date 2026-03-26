import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';
import '../respository/search_repository.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  final SearchRepository repository = SearchRepository();
  final String uid;

  List<MealModel> meals = [];
  List<MealModel> searchHistory = [];
  List<MealModel> lastViewed = [];

  String get _searchHistoryKey => 'search_history_$uid';
  String get _lastViewedKey => 'last_viewed_$uid';

  SearchCubit({required this.uid}) : super(SearchInitialState()) {
    loadFromPrefs();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final historyJson = prefs.getString(_searchHistoryKey);
    if (historyJson != null) {
      final List decoded = jsonDecode(historyJson);
      searchHistory = decoded.map((e) => MealModel.fromJson(e)).toList();
    }

    final viewedJson = prefs.getString(_lastViewedKey);
    if (viewedJson != null) {
      final List decoded = jsonDecode(viewedJson);
      lastViewed = decoded.map((e) => MealModel.fromJson(e)).toList();
    }

    emit(SearchSuccessState(
      meals: meals,
      searchHistory: searchHistory,
      lastViewed: lastViewed,
    ));
  }

  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(searchHistory.map((m) => m.toJson()).toList());
    await prefs.setString(_searchHistoryKey, encoded);
  }

  Future<void> _saveLastViewed() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(lastViewed.map((m) => m.toJson()).toList());
    await prefs.setString(_lastViewedKey, encoded);
  }

  Future<void> searchMeals(String query) async {
    if (query.isEmpty) return;
    emit(SearchLoadingState());
    try {
      meals = await repository.searchMeals(query);
      emit(SearchSuccessState(
        meals: meals,
        searchHistory: searchHistory,
        lastViewed: lastViewed,
      ));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  Future<void> addToLastViewed(MealModel meal) async {
    lastViewed.removeWhere((m) => m.idMeal == meal.idMeal);
    lastViewed.insert(0, meal);
    await _saveLastViewed();
    emit(SearchSuccessState(
      meals: meals,
      searchHistory: searchHistory,
      lastViewed: lastViewed,
    ));
  }

  Future<void> addToSearchHistory(MealModel meal) async {
    searchHistory.removeWhere((m) => m.idMeal == meal.idMeal);
    searchHistory.insert(0, meal);
    await _saveSearchHistory();
    emit(SearchSuccessState(
      meals: meals,
      searchHistory: searchHistory,
      lastViewed: lastViewed,
    ));
  }
}
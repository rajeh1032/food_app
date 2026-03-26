import '../models/meal_model.dart';
import '../services/search_api_service.dart';

class SearchRepository {
  final SearchApiService apiService =
  SearchApiService();

  Future<List<MealModel>> searchMeals(
      String query) async {
    return await apiService.searchMeals(query);
  }
}
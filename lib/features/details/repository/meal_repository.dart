import '../models/meal_model.dart';
import '../services/api_service.dart';

class MealRepository {
  final ApiService apiService;

  MealRepository(this.apiService);

  Future<List<Meal>> fetchMeals() => apiService.getMeals();

  Future<Meal> fetchMealDetails(String id) => apiService.getMealDetails(id);
}
import 'package:dio/dio.dart';
import '../../../core/api manager/api_endpoints.dart';
import '../models/meal_model.dart';

class ApiService {
  final Dio dio;

  ApiService({Dio? dio}) : dio = dio ?? Dio(); // لو مش بعتي dio هينشأ واحد جديد

  final String baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  Future<List<Meal>> getMeals() async {
    try {
      final response = await dio.get("${baseUrl}search.php?f=a");

      if (response.statusCode == 200) {
        final data = response.data;
        final mealsJson = data['meals'] as List;
        return mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<Meal> getMealDetails(String id) async {
    try {
      final response = await dio.get("${ApiEndpoints.lookupMealById}?i=$id");

      if (response.statusCode == 200) {
        final data = response.data;
        final mealJson = data['meals'][0];
        return Meal.fromJson(mealJson);
      } else {
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      throw Exception('Failed to load meal details: $e');
    }
  }
}
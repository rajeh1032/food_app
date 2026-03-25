import 'package:dio/dio.dart';
import '../../../../core/api manager/api_endpoints.dart';
import '../models/search_response_model.dart';
import '../models/meal_model.dart';

class SearchApiService {
  final Dio dio = Dio();


  Future<List<MealModel>> searchMeals(String query) async {
    try {
      Response response = await dio.get(
        "${ApiEndpoints.searchMealByFirstLetter}?s=$query",

      );

      SearchResponseModel searchResponse =
      SearchResponseModel.fromJson(response.data);

      return searchResponse.meals ?? [];

    } catch (e) {
      print("Search API Error: $e");
      return [];
    }
  }
}
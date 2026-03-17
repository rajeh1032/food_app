import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../Entity/home_category_entity.dart';
import '../Entity/home_ingredient_entity.dart';
import '../Entity/home_meal_entity.dart';
import '../Repository/home_repository.dart';

@injectable
class HomeUseCase {
  final HomeRepository homeRepository;

  HomeUseCase({required this.homeRepository});

  Future<Either<Failures, List<HomeIngredientEntity>>> getIngredientsInvoke() {
    return homeRepository.getIngredients();
  }

  Future<Either<Failures, List<HomeCategoryEntity>>> getCategoriesInvoke() {
    return homeRepository.getCategories();
  }

  Future<Either<Failures, List<HomeMealEntity>>> getMealsByIngredientInvoke(
    String ingredient,
  ) {
    return homeRepository.getMealsByIngredient(ingredient);
  }

  Future<Either<Failures, List<HomeMealEntity>>> getMealsByCategoryInvoke(
    String category,
  ) {
    return homeRepository.getMealsByCategory(category);
  }
}

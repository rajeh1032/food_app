import 'package:either_dart/either.dart';
import '../../../../../core/model/failures.dart';
import '../../../Domain/Entity/home_category_entity.dart';
import '../../../Domain/Entity/home_ingredient_entity.dart';
import '../../../Domain/Entity/home_meal_entity.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failures, List<HomeIngredientEntity>>> getIngredients();

  Future<Either<Failures, List<HomeCategoryEntity>>> getCategories();

  Future<Either<Failures, List<HomeMealEntity>>> getMealsByIngredient(
    String ingredient,
  );

  Future<Either<Failures, List<HomeMealEntity>>> getMealsByCategory(
    String category,
  );
}

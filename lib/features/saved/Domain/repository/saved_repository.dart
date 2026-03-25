import 'package:either_dart/either.dart';
import '../entity/saved_meal_entity.dart';
import '../../../../core/model/failures.dart';

abstract class SavedRepository {
  Future<Either<Failures, List<SavedMealEntity>>> getSavedMeals(String userId);

  Future<Either<Failures, void>> saveMeal(SavedMealEntity meal);

  Future<Either<Failures, void>> removeMeal(
      {required String mealId, required String userId});

  Future<bool> isMealSaved(
      {required String mealId, required String userId});
}
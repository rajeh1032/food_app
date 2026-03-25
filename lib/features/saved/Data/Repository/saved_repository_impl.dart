import 'package:either_dart/either.dart';
import 'package:food_app/core/model/failures.dart';
import 'package:food_app/features/saved/Data/Models/saved_meal_model.dart';
import 'package:food_app/features/saved/Domain/entity/saved_meal_entity.dart';
import 'package:food_app/features/saved/Domain/repository/saved_repository.dart';
import 'package:injectable/injectable.dart';
import '../Data Sources/saved_local_data_source.dart';

@LazySingleton(as: SavedRepository)
class SavedRepositoryImpl implements SavedRepository {
  final SavedLocalDataSource _localDataSource;

  SavedRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failures, List<SavedMealEntity>>> getSavedMeals(
      String userId) async {
    try {
      final models = await _localDataSource.getSavedMeals(userId);
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> saveMeal(SavedMealEntity meal) async {
    try {
      final model = SavedMealModel.fromEntity(meal);
      await _localDataSource.saveMeal(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> removeMeal({
    required String mealId,
    required String userId,
  }) async {
    try {
      await _localDataSource.removeMeal(mealId: mealId, userId: userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<bool> isMealSaved({
    required String mealId,
    required String userId,
  }) async {
    try {
      return await _localDataSource.isMealSaved(mealId: mealId, userId: userId);
    } catch (_) {
      return false;
    }
  }
}

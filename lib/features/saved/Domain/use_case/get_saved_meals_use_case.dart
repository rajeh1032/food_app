import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../entity/saved_meal_entity.dart';
import '../../../../core/model/failures.dart';
import '../repository/saved_repository.dart';
@injectable
class GetSavedMealsUseCase {
  final SavedRepository _repository;

  GetSavedMealsUseCase(this._repository);

  Future<Either<Failures, List<SavedMealEntity>>> call(String userId) {
    return _repository.getSavedMeals(userId);
  }
}
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../entity/saved_meal_entity.dart';
import '../../../../core/model/failures.dart';
import '../repository/saved_repository.dart';
@injectable
class SaveMealUseCase {
  final SavedRepository _repository;

  SaveMealUseCase(this._repository);

  Future<Either<Failures, void>> call(SavedMealEntity meal) {
    return _repository.saveMeal(meal);
  }
}
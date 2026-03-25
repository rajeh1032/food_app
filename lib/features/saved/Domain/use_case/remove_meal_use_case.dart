import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../repository/saved_repository.dart';
@injectable
class RemoveMealUseCase {
  final SavedRepository _repository;

  RemoveMealUseCase(this._repository);

  Future<Either<Failures, void>> call({
    required String mealId,
    required String userId,
  }) {
    return _repository.removeMeal(mealId: mealId, userId: userId);
  }
}
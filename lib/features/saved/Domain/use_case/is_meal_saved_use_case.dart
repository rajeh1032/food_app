import 'package:injectable/injectable.dart';

import '../repository/saved_repository.dart';
@injectable
class IsMealSavedUseCase {
  final SavedRepository _repository;

  IsMealSavedUseCase(this._repository);

  Future<bool> call({required String mealId, required String userId}) {
    return _repository.isMealSaved(mealId: mealId, userId: userId);
  }
}
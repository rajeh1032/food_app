import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Domain/entity/saved_meal_entity.dart';
import '../../Domain/use_case/get_saved_meals_use_case.dart';
import '../../Domain/use_case/is_meal_saved_use_case.dart';
import '../../Domain/use_case/remove_meal_use_case.dart';
import '../../Domain/use_case/save_meal_use_case.dart';
import 'saved_states.dart';
@lazySingleton
class SavedViewModel extends Cubit<SavedState> {
  final GetSavedMealsUseCase _getSavedMeals;
  final SaveMealUseCase _saveMeal;
  final RemoveMealUseCase _removeMeal;
  final IsMealSavedUseCase _isMealSaved;
  final Set<String> _savedIds = {};

  SavedViewModel({
    required GetSavedMealsUseCase getSavedMeals,
    required SaveMealUseCase saveMeal,
    required RemoveMealUseCase removeMeal,
    required IsMealSavedUseCase isMealSaved,
  })  : _getSavedMeals = getSavedMeals,
        _saveMeal = saveMeal,
        _removeMeal = removeMeal,
        _isMealSaved = isMealSaved,
        super(SavedInitialState());


  Future<void> loadSavedMeals(String userId) async {
    emit(SavedLoadingState());
    final result = await _getSavedMeals(userId);
    result.fold(
          (failure) => emit(SavedErrorState(failure.errorMessage)),
          (meals) {
        _savedIds
          ..clear()
          ..addAll(meals.map((m) => m.mealId));
        emit(SavedSuccessState(meals));
      },
    );
  }


  Future<void> toggleBookmark({
    required String userId,
    required String mealId,
    required String mealName,
    required String mealThumb,
    required String rating,
    required String time,
    required String views,
  }) async {
    final alreadySaved =
        _savedIds.contains(mealId) ||
            await _isMealSaved(mealId: mealId, userId: userId);

    if (alreadySaved) {
      _savedIds.add(mealId);
    }

    if (alreadySaved) {
      final result = await _removeMeal(mealId: mealId, userId: userId);
      await result.fold(
            (failure) async => emit(SavedErrorState(failure.errorMessage)),
            (_) async {
          _savedIds.remove(mealId);
          emit(BookmarkToggledState(mealId: mealId, isSaved: false));
          await _refreshListAfterToggle(userId);
        },
      );
    } else {
      final result = await _saveMeal(
        SavedMealEntity(
          mealId: mealId,
          mealName: mealName,
          mealThumb: mealThumb,
          userId: userId,
          rating: rating,
          time: time,
          views: views,
        ),
      );
      await result.fold(
            (failure) async => emit(SavedErrorState(failure.errorMessage)),
            (_) async {
          _savedIds.add(mealId);
          emit(BookmarkToggledState(mealId: mealId, isSaved: true));
          await _refreshListAfterToggle(userId);
        },
      );
    }
  }

  Future<void> _refreshListAfterToggle(String userId) async {
    final result = await _getSavedMeals(userId);
    result.fold(
          (_) {},
          (meals) {
        _savedIds
          ..clear()
          ..addAll(meals.map((m) => m.mealId));
        emit(SavedSuccessState(meals));
      },
    );
  }


  bool isSaved(String mealId) => _savedIds.contains(mealId);


  Future<void> preloadSavedIds(String userId) async {
    final result = await _getSavedMeals(userId);
    result.fold(
          (_) {},
          (meals) {
        _savedIds
          ..clear()
          ..addAll(meals.map((m) => m.mealId));
      },
    );
  }
}

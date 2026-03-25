import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Domain/entity/saved_meal_entity.dart';
import '../../Domain/use_case/get_saved_meals_use_case.dart';
import '../../Domain/use_case/is_meal_saved_use_case.dart';
import '../../Domain/use_case/remove_meal_use_case.dart';
import '../../Domain/use_case/save_meal_use_case.dart';
import 'saved_states.dart';
@injectable
class SavedViewModel extends Cubit<SavedState> {
  final GetSavedMealsUseCase _getSavedMeals;
  final SaveMealUseCase _saveMeal;
  final RemoveMealUseCase _removeMeal;
  final IsMealSavedUseCase _isMealSaved;

  // In-memory cache of saved meal IDs for fast lookup
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

  // ─── Load saved meals for current user ───────────────────────────────────

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

  // ─── Toggle bookmark from Home or Details ────────────────────────────────

  Future<void> toggleBookmark({
    required String userId,
    required String mealId,
    required String mealName,
    required String mealThumb,
  }) async {
    final alreadySaved = _savedIds.contains(mealId);

    if (alreadySaved) {
      await _removeMeal(mealId: mealId, userId: userId);
      _savedIds.remove(mealId);
      emit(BookmarkToggledState(mealId: mealId, isSaved: false));

      // Refresh the saved list if it was already loaded
      _refreshListAfterToggle(userId);
    } else {
      await _saveMeal(
        SavedMealEntity(
          mealId: mealId,
          mealName: mealName,
          mealThumb: mealThumb,
          userId: userId,
        ),
      );
      _savedIds.add(mealId);
      emit(BookmarkToggledState(mealId: mealId, isSaved: true));

      _refreshListAfterToggle(userId);
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

  // ─── Check if a single meal is saved (sync from cache) ───────────────────

  bool isSaved(String mealId) => _savedIds.contains(mealId);

  // ─── Preload saved IDs without changing screen state ─────────────────────

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
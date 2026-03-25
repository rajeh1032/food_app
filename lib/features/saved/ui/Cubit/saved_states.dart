import '../../Domain/entity/saved_meal_entity.dart';

abstract class SavedState {}

class SavedInitialState extends SavedState {}

class SavedLoadingState extends SavedState {}

class SavedSuccessState extends SavedState {
  final List<SavedMealEntity> meals;
  SavedSuccessState(this.meals);
}

class SavedErrorState extends SavedState {
  final String message;
  SavedErrorState(this.message);
}

/// Emitted after toggling bookmark so Home/Details can react
class BookmarkToggledState extends SavedState {
  final String mealId;
  final bool isSaved;
  BookmarkToggledState({required this.mealId, required this.isSaved});
}
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../Models/saved_meal_model.dart';

abstract class SavedLocalDataSource {
  Future<List<SavedMealModel>> getSavedMeals(String userId);
  Future<void> saveMeal(SavedMealModel meal);
  Future<void> removeMeal({required String mealId, required String userId});
  Future<bool> isMealSaved({required String mealId, required String userId});
}

@Injectable(as: SavedLocalDataSource)
class SavedLocalDataSourceImpl implements SavedLocalDataSource {
  static final Map<String, Future<Box<SavedMealModel>>> _openingBoxes = {};

  // Each user gets their own box: "saved_<userId>"
  Future<Box<SavedMealModel>> _getBox(String userId) async {
    await openBoxForUser(userId);
    return Hive.box<SavedMealModel>('saved_$userId');
  }

  // Call this before using the box for a specific user
  static Future<Box<SavedMealModel>> openBoxForUser(String userId) async {
    final boxName = 'saved_$userId';

    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<SavedMealModel>(boxName);
    }

    return _openingBoxes.putIfAbsent(boxName, () async {
      try {
        return await Hive.openBox<SavedMealModel>(boxName);
      } finally {
        _openingBoxes.remove(boxName);
      }
    });
  }

  @override
  Future<List<SavedMealModel>> getSavedMeals(String userId) async {
    final box = await _getBox(userId);
    return box.values.toList();
  }

  @override
  Future<void> saveMeal(SavedMealModel meal) async {
    final box = await _getBox(meal.userId);
    // Key = mealId so we avoid duplicates
    await box.put(meal.mealId, meal);
  }

  @override
  Future<void> removeMeal({
    required String mealId,
    required String userId,
  }) async {
    final box = await _getBox(userId);
    await box.delete(mealId);
  }

  @override
  Future<bool> isMealSaved({
    required String mealId,
    required String userId,
  }) async {
    final box = await _getBox(userId);
    return box.containsKey(mealId);
  }
}

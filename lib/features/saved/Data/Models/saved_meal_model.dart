import 'package:hive/hive.dart';
import '../../Domain/entity/saved_meal_entity.dart';
part 'saved_meal_model.g.dart';
@HiveType(typeId: 1)
class SavedMealModel extends HiveObject {
  @HiveField(0)
  final String mealId;

  @HiveField(1)
  final String mealName;

  @HiveField(2)
  final String mealThumb;

  @HiveField(3)
  final String userId;

  SavedMealModel({
    required this.mealId,
    required this.mealName,
    required this.mealThumb,
    required this.userId,
  });

  factory SavedMealModel.fromEntity(SavedMealEntity entity) {
    return SavedMealModel(
      mealId: entity.mealId,
      mealName: entity.mealName,
      mealThumb: entity.mealThumb,
      userId: entity.userId,
    );
  }

  SavedMealEntity toEntity() {
    return SavedMealEntity(
      mealId: mealId,
      mealName: mealName,
      mealThumb: mealThumb,
      userId: userId,
    );
  }
}
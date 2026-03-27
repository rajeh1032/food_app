class SavedMealEntity {
  final String mealId;
  final String mealName;
  final String mealThumb;
  final String userId;
  final String rating;
  final String time;
  final String views;

  const SavedMealEntity({
    required this.mealId,
    required this.mealName,
    required this.mealThumb,
    required this.userId,
    required this.rating,
    required this.time,
    required this.views,
  });
}
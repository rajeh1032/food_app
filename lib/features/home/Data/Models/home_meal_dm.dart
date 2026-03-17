import '../../Domain/Entity/home_meal_entity.dart';

class HomeMealDm extends HomeMealEntity {
  HomeMealDm({super.idMeal, super.strMeal, super.strMealThumb});

  HomeMealDm.fromJson(dynamic json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idMeal'] = idMeal;
    map['strMeal'] = strMeal;
    map['strMealThumb'] = strMealThumb;
    return map;
  }
}

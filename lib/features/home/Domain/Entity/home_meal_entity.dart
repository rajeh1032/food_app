class HomeMealEntity {
  HomeMealEntity({this.idMeal, this.strMeal, this.strMealThumb});

  HomeMealEntity.fromJson(dynamic json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
  }

  String? idMeal;
  String? strMeal;
  String? strMealThumb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idMeal'] = idMeal;
    map['strMeal'] = strMeal;
    map['strMealThumb'] = strMealThumb;
    return map;
  }
}

import '../../Domain/Entity/home_ingredient_entity.dart';

class HomeIngredientDm extends HomeIngredientEntity {
  HomeIngredientDm({
    super.idIngredient,
    super.strIngredient,
    super.strDescription,
    super.strThumb,
    super.strType,
  });

  HomeIngredientDm.fromJson(dynamic json) {
    idIngredient = json['idIngredient'];
    strIngredient = json['strIngredient'];
    strDescription = json['strDescription'];
    strThumb = json['strThumb'];
    strType = json['strType'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idIngredient'] = idIngredient;
    map['strIngredient'] = strIngredient;
    map['strDescription'] = strDescription;
    map['strThumb'] = strThumb;
    map['strType'] = strType;
    return map;
  }
}

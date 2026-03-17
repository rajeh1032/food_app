class HomeIngredientEntity {
  HomeIngredientEntity({
    this.idIngredient,
    this.strIngredient,
    this.strDescription,
    this.strThumb,
    this.strType,
  });

  HomeIngredientEntity.fromJson(dynamic json) {
    idIngredient = json['idIngredient'];
    strIngredient = json['strIngredient'];
    strDescription = json['strDescription'];
    strThumb = json['strThumb'];
    strType = json['strType'];
  }

  String? idIngredient;
  String? strIngredient;
  String? strDescription;
  String? strThumb;
  String? strType;

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

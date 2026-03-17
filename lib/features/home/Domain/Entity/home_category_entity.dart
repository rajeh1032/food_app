class HomeCategoryEntity {
  HomeCategoryEntity({this.strCategory});

  HomeCategoryEntity.fromJson(dynamic json) {
    strCategory = json['strCategory'];
  }

  String? strCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strCategory'] = strCategory;
    return map;
  }
}

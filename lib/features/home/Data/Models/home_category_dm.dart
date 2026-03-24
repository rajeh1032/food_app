import '../../Domain/Entity/home_category_entity.dart';

class HomeCategoryDm extends HomeCategoryEntity {
  HomeCategoryDm({super.strCategory});

  HomeCategoryDm.fromJson(dynamic json) {
    strCategory = json['strCategory'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strCategory'] = strCategory;
    return map;
  }
}

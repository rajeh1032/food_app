import '../../Domain/Entity/profile_user_entity.dart';

/// Profile user data model
class ProfileUserDm extends ProfileUserEntity {
  ProfileUserDm({
    super.uid,
    super.email,
    super.name,
    super.createdAt,
    super.updatedAt,
  });

  ProfileUserDm.fromJson(dynamic json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['email'] = email;
    map['name'] = name;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

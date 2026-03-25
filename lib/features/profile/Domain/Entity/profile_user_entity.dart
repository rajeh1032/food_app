/// Profile user entity
class ProfileUserEntity {
  String? uid;
  String? email;
  String? name;
  String? createdAt;
  String? updatedAt;

  ProfileUserEntity({
    this.uid,
    this.email,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  ProfileUserEntity.fromJson(dynamic json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

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

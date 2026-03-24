import 'auth_user_entity.dart';

/// Domain entity representing login response
class LoginResponseEntity {
  String? message;
  AuthUserEntity? user;

  LoginResponseEntity({this.message, this.user});

  LoginResponseEntity.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? AuthUserEntity.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }
}

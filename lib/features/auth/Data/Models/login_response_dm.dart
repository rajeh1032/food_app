import '../../Domain/Entity/login_response_entity.dart';
import 'auth_user_dm.dart';

/// Data model for login response (extends domain entity)
class LoginResponseDm extends LoginResponseEntity {
  LoginResponseDm({super.message, super.user});

  LoginResponseDm.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? AuthUserDm.fromJson(json['user']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }
}

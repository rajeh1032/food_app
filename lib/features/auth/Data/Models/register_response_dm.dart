import '../../Domain/Entity/register_response_entity.dart';
import 'auth_user_dm.dart';

/// Data model for registration response (extends domain entity)
class RegisterResponseDm extends RegisterResponseEntity {
  RegisterResponseDm({super.message, super.user});

  RegisterResponseDm.fromJson(dynamic json) {
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Domain/Entity/auth_user_entity.dart';

/// Data model for authenticated user (extends domain entity)
class AuthUserDm extends AuthUserEntity {
  AuthUserDm({
    super.uid,
    super.email,
    super.name,
    super.createdAt,
    super.updatedAt,
  });

  /// Create from Firebase User
  AuthUserDm.fromFirebaseUser(User user) {
    uid = user.uid;
    email = user.email;
    name = user.displayName;
    createdAt = user.metadata.creationTime?.toIso8601String();
    updatedAt = DateTime.now().toIso8601String();
  }

  /// Create from Firestore document
  AuthUserDm.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      uid = data['uid'];
      email = data['email'];
      name = data['name'];
      createdAt = data['createdAt'];
      updatedAt = data['updatedAt'];
    }
  }

  /// Create from JSON
  AuthUserDm.fromJson(dynamic json) {
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

  /// Convert to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': createdAt ?? DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}

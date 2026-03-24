import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseAuth provideFirebaseAuth() {
    return FirebaseAuth.instance;
  }

  @lazySingleton
  FirebaseFirestore provideFirebaseFirestore() {
    return FirebaseFirestore.instance;
  }
}

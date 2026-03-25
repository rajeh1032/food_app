import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/model/failures.dart';
import '../../../../../../core/services/firebase_auth_service.dart';
import '../../../../../../core/services/firestore_service.dart';
import '../../../../../../core/utils/shared_pref_services.dart';
import '../../../../../../core/utils/firebase_error_mapper.dart';
import '../../../../Domain/Entity/auth_user_entity.dart';
import '../../../../Domain/Entity/login_response_entity.dart';
import '../../../../Domain/Entity/register_response_entity.dart';
import '../../../Models/auth_user_dm.dart';
import '../../../Models/login_response_dm.dart';
import '../../../Models/register_response_dm.dart';
import '../auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;

  AuthRemoteDataSourceImpl({
    required this.authService,
    required this.firestoreService,
  });

  @override
  Future<Either<Failures, RegisterResponseEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Firebase Auth user
      final userCredential = await authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return Left(AuthError(errorMessage: 'Failed to create user'));
      }

      // 2. Create user data model
      final authUser = AuthUserDm(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        name: name,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      // 3. Store user profile in Firestore
      await firestoreService.setDocument(
        path: 'users/${firebaseUser.uid}',
        data: authUser.toFirestore(),
      );

      // 4. Persist user ID locally
      await SharedPrefService.instance.setUserId(firebaseUser.uid);

      // 5. Return success response
      final response = RegisterResponseDm(
        message: 'Registration successful',
        user: authUser,
      );

      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(AuthError(errorMessage: FirebaseErrorMapper.mapAuthError(e)));
    } catch (e) {
      return Left(
        AuthError(errorMessage: 'Registration failed: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Sign in with Firebase Auth
      final userCredential = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return Left(AuthError(errorMessage: 'Login failed'));
      }

      // 2. Fetch user profile from Firestore
      AuthUserDm authUser;
      try {
        final userDoc = await firestoreService.getDocument(
          'users/${firebaseUser.uid}',
        );

        if (userDoc.exists) {
          authUser = AuthUserDm.fromFirestore(userDoc);
        } else {
          // Fallback: create user profile from Firebase Auth data
          authUser = AuthUserDm.fromFirebaseUser(firebaseUser);
          await firestoreService.setDocument(
            path: 'users/${firebaseUser.uid}',
            data: authUser.toFirestore(),
          );
        }
      } catch (e) {
        // Fallback: use Firebase Auth data
        authUser = AuthUserDm.fromFirebaseUser(firebaseUser);
      }

      // 3. Persist user ID locally
      await SharedPrefService.instance.setUserId(firebaseUser.uid);

      // 4. Return success response
      final response = LoginResponseDm(
        message: 'Login successful',
        user: authUser,
      );

      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(AuthError(errorMessage: FirebaseErrorMapper.mapAuthError(e)));
    } catch (e) {
      return Left(AuthError(errorMessage: 'Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failures, bool>> logout() async {
    try {
      // 1. Sign out from Firebase
      await authService.signOut();

      // 2. Clear persisted user ID
      await SharedPrefService.instance.clearUserId();

      return const Right(true);
    } catch (e) {
      return Left(AuthError(errorMessage: 'Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failures, AuthUserEntity?>> getCurrentUser() async {
    try {
      final firebaseUser = authService.currentUser;

      if (firebaseUser == null) {
        return const Right(null);
      }

      // Fetch user profile from Firestore
      final userDoc = await firestoreService.getDocument(
        'users/${firebaseUser.uid}',
      );

      if (userDoc.exists) {
        final authUser = AuthUserDm.fromFirestore(userDoc);
        return Right(authUser);
      }

      // Fallback: return user from Firebase Auth
      final authUser = AuthUserDm.fromFirebaseUser(firebaseUser);
      return Right(authUser);
    } catch (e) {
      return Left(
        AuthError(errorMessage: 'Failed to get current user: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failures, String?>> getCurrentUserId() async {
    try {
      // Try to get from local storage first
      final localUserId = SharedPrefService.instance.getUserId();
      if (localUserId != null && localUserId.isNotEmpty) {
        return Right(localUserId);
      }

      // Fallback: get from Firebase Auth
      final firebaseUser = authService.currentUser;
      if (firebaseUser != null) {
        // Persist it locally for next time
        await SharedPrefService.instance.setUserId(firebaseUser.uid);
        return Right(firebaseUser.uid);
      }

      return const Right(null);
    } catch (e) {
      return Left(
        AuthError(errorMessage: 'Failed to get user ID: ${e.toString()}'),
      );
    }
  }
}

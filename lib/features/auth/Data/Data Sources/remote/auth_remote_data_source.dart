import 'package:either_dart/either.dart';
import '../../../../../core/model/failures.dart';
import '../../../Domain/Entity/auth_user_entity.dart';
import '../../../Domain/Entity/login_response_entity.dart';
import '../../../Domain/Entity/register_response_entity.dart';

/// Abstract interface for authentication remote data source
abstract class AuthRemoteDataSource {
  /// Register a new user with Firebase Auth and create Firestore profile
  Future<Either<Failures, RegisterResponseEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Login user with Firebase Auth and fetch Firestore profile
  Future<Either<Failures, LoginResponseEntity>> login({
    required String email,
    required String password,
  });

  /// Logout current user from Firebase Auth
  Future<Either<Failures, bool>> logout();

  /// Get current authenticated user from Firestore
  Future<Either<Failures, AuthUserEntity?>> getCurrentUser();

  /// Get current user ID from local storage or Firebase Auth
  Future<Either<Failures, String?>> getCurrentUserId();
}

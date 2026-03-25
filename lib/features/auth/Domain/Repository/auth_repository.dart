import 'package:either_dart/either.dart';
import '../../../../core/model/failures.dart';
import '../Entity/auth_user_entity.dart';
import '../Entity/login_response_entity.dart';
import '../Entity/register_response_entity.dart';

/// Abstract repository contract for authentication operations
abstract class AuthRepository {
  /// Register a new user with email and password
  Future<Either<Failures, RegisterResponseEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Login user with email and password
  Future<Either<Failures, LoginResponseEntity>> login({
    required String email,
    required String password,
  });

  /// Logout current user
  Future<Either<Failures, bool>> logout();

  /// Get current authenticated user
  Future<Either<Failures, AuthUserEntity?>> getCurrentUser();

  /// Get current user ID
  Future<Either<Failures, String?>> getCurrentUserId();
}

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../Entity/auth_user_entity.dart';
import '../Entity/login_response_entity.dart';
import '../Entity/register_response_entity.dart';
import '../Repository/auth_repository.dart';

/// Use case for authentication operations
@injectable
class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  /// Register a new user
  Future<Either<Failures, RegisterResponseEntity>> registerInvoke({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(name: name, email: email, password: password);
  }

  /// Login user
  Future<Either<Failures, LoginResponseEntity>> loginInvoke({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }

  /// Logout user
  Future<Either<Failures, bool>> logoutInvoke() {
    return repository.logout();
  }

  /// Get current user
  Future<Either<Failures, AuthUserEntity?>> getCurrentUserInvoke() {
    return repository.getCurrentUser();
  }

  /// Get current user ID
  Future<Either<Failures, String?>> getCurrentUserIdInvoke() {
    return repository.getCurrentUserId();
  }
}

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../../Domain/Entity/auth_user_entity.dart';
import '../../Domain/Entity/login_response_entity.dart';
import '../../Domain/Entity/register_response_entity.dart';
import '../../Domain/Repository/auth_repository.dart';
import '../Data Sources/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, RegisterResponseEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<Either<Failures, bool>> logout() async {
    return await remoteDataSource.logout();
  }

  @override
  Future<Either<Failures, AuthUserEntity?>> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }

  @override
  Future<Either<Failures, String?>> getCurrentUserId() async {
    return await remoteDataSource.getCurrentUserId();
  }
}

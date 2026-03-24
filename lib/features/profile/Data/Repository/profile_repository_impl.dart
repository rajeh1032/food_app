import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../../Domain/Entity/profile_user_entity.dart';
import '../../Domain/Repository/profile_repository.dart';
import '../Data Sources/remote/profile_remote_data_source.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, ProfileUserEntity>> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<Either<Failures, ProfileUserEntity>> updateName({
    required String name,
  }) async {
    return await remoteDataSource.updateName(name: name);
  }

  @override
  Future<Either<Failures, bool>> logout() async {
    return await remoteDataSource.logout();
  }
}

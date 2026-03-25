import 'package:either_dart/either.dart';
import '../../../../../core/model/failures.dart';
import '../../../Domain/Entity/profile_user_entity.dart';

/// Profile remote data source contract
abstract class ProfileRemoteDataSource {
  Future<Either<Failures, ProfileUserEntity>> getProfile();
  Future<Either<Failures, ProfileUserEntity>> updateName({
    required String name,
  });
  Future<Either<Failures, bool>> logout();
}

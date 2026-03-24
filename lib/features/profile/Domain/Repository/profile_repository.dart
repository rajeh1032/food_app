import 'package:either_dart/either.dart';
import '../../../../core/model/failures.dart';
import '../Entity/profile_user_entity.dart';

/// Profile repository contract
abstract class ProfileRepository {
  Future<Either<Failures, ProfileUserEntity>> getProfile();
  Future<Either<Failures, ProfileUserEntity>> updateName({
    required String name,
  });
  Future<Either<Failures, bool>> logout();
}

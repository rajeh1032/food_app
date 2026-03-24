import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../Entity/profile_user_entity.dart';
import '../Repository/profile_repository.dart';

@injectable
class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase({required this.repository});

  Future<Either<Failures, ProfileUserEntity>> getProfileInvoke() {
    return repository.getProfile();
  }

  Future<Either<Failures, ProfileUserEntity>> updateNameInvoke({
    required String name,
  }) {
    return repository.updateName(name: name);
  }

  Future<Either<Failures, bool>> logoutInvoke() {
    return repository.logout();
  }
}

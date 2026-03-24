import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/model/failures.dart';
import '../../../../../../core/services/firebase_auth_service.dart';
import '../../../../../../core/services/firestore_service.dart';
import '../../../../../../core/utils/shared_pref_services.dart';
import '../../../../Domain/Entity/profile_user_entity.dart';
import '../../../Models/profile_user_dm.dart';
import '../profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirestoreService firestoreService;
  final FirebaseAuthService authService;

  ProfileRemoteDataSourceImpl({
    required this.firestoreService,
    required this.authService,
  });

  @override
  Future<Either<Failures, ProfileUserEntity>> getProfile() async {
    try {
      // Get current user ID
      final userId =
          SharedPrefService.instance.getUserId() ??
          authService.currentUser?.uid;

      if (userId == null) {
        return Left(ServerError(errorMessage: 'User not authenticated'));
      }

      // Fetch user document from Firestore
      final docSnapshot = await firestoreService.getDocument('users/$userId');

      if (!docSnapshot.exists) {
        return Left(ServerError(errorMessage: 'User profile not found'));
      }

      final data = docSnapshot.data() as Map<String, dynamic>;
      final profile = ProfileUserDm.fromJson(data);

      return Right(profile);
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, ProfileUserEntity>> updateName({
    required String name,
  }) async {
    try {
      // Get current user ID
      final userId =
          SharedPrefService.instance.getUserId() ??
          authService.currentUser?.uid;

      if (userId == null) {
        return Left(ServerError(errorMessage: 'User not authenticated'));
      }

      // Update user document in Firestore
      await firestoreService.updateDocument(
        path: 'users/$userId',
        data: {'name': name, 'updatedAt': DateTime.now().toIso8601String()},
      );

      // Fetch updated profile
      final docSnapshot = await firestoreService.getDocument('users/$userId');
      final data = docSnapshot.data() as Map<String, dynamic>;
      final profile = ProfileUserDm.fromJson(data);

      return Right(profile);
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> logout() async {
    try {
      // Sign out from Firebase
      await authService.signOut();

      // Clear local user ID
      await SharedPrefService.instance.clearUserId();
      await SharedPrefService.instance.clearToken();

      return const Right(true);
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}

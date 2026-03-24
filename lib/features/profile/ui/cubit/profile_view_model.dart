import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Domain/Entity/profile_user_entity.dart';
import '../../Domain/Use Case/profile_use_case.dart';
import 'profile_states.dart';

@injectable
class ProfileViewModel extends HydratedCubit<ProfileStates> {
  final ProfileUseCase useCase;

  ProfileViewModel({required this.useCase}) : super(ProfileInitialState());

  /// Get current user profile
  void getProfile() async {
    emit(ProfileLoadingState());

    final result = await useCase.getProfileInvoke();

    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.errorMessage)),
      (user) => emit(ProfileLoadedState(user: user)),
    );
  }

  /// Update user name
  void updateName(String name) async {
    emit(ProfileLoadingState());

    final result = await useCase.updateNameInvoke(name: name);

    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.errorMessage)),
      (user) => emit(ProfileUpdatedState(user: user)),
    );
  }

  /// Logout user
  void logout() async {
    emit(ProfileLoadingState());

    final result = await useCase.logoutInvoke();

    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.errorMessage)),
      (success) => emit(ProfileLogoutSuccessState()),
    );
  }

  @override
  ProfileStates? fromJson(Map<String, dynamic> json) {
    try {
      final stateType = json['state'] as String?;

      switch (stateType) {
        case 'loaded':
          return ProfileLoadedState(
            user: ProfileUserEntity.fromJson(json['user']),
          );
        case 'updated':
          return ProfileUpdatedState(
            user: ProfileUserEntity.fromJson(json['user']),
          );
        case 'logout_success':
          return ProfileLogoutSuccessState();
        case 'error':
          return ProfileErrorState(message: json['message'] as String);
        case 'loading':
          return ProfileLoadingState();
        default:
          return ProfileInitialState();
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ProfileStates state) {
    try {
      if (state is ProfileLoadedState) {
        return {'state': 'loaded', 'user': state.user.toJson()};
      } else if (state is ProfileUpdatedState) {
        return {'state': 'updated', 'user': state.user.toJson()};
      } else if (state is ProfileLogoutSuccessState) {
        return {'state': 'logout_success'};
      } else if (state is ProfileErrorState) {
        return {'state': 'error', 'message': state.message};
      } else if (state is ProfileLoadingState) {
        return {'state': 'loading'};
      }
      return {'state': 'initial'};
    } catch (e) {
      return null;
    }
  }
}

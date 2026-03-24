import '../../Domain/Entity/profile_user_entity.dart';

/// Profile states
abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileErrorState extends ProfileStates {
  final String message;
  ProfileErrorState({required this.message});
}

class ProfileLoadedState extends ProfileStates {
  final ProfileUserEntity user;
  ProfileLoadedState({required this.user});
}

class ProfileUpdatedState extends ProfileStates {
  final ProfileUserEntity user;
  ProfileUpdatedState({required this.user});
}

class ProfileLogoutSuccessState extends ProfileStates {}

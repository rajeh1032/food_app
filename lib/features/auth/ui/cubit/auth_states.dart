import '../../Domain/Entity/auth_user_entity.dart';

/// Base class for all authentication states
abstract class AuthStates {}

/// Initial state when auth feature is first loaded
class AuthInitialState extends AuthStates {}

/// Loading state during authentication operations
class AuthLoadingState extends AuthStates {}

/// Error state when authentication operation fails
class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState({required this.message});
}

/// Success state after successful login
class LoginSuccessState extends AuthStates {
  final AuthUserEntity user;
  final String uid;

  LoginSuccessState({required this.user, required this.uid});
}

/// Success state after successful registration
class RegisterSuccessState extends AuthStates {
  final AuthUserEntity user;
  final String uid;

  RegisterSuccessState({required this.user, required this.uid});
}

/// Success state after successful logout
class LogoutSuccessState extends AuthStates {}

/// State when authenticated user data is loaded
class AuthenticatedUserLoadedState extends AuthStates {
  final AuthUserEntity? user;
  AuthenticatedUserLoadedState({this.user});
}

/// State when current user ID is loaded
class CurrentUserIdLoadedState extends AuthStates {
  final String? uid;
  CurrentUserIdLoadedState({this.uid});
}

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Domain/Entity/auth_user_entity.dart';
import '../../Domain/Use Case/auth_use_case.dart';
import 'auth_states.dart';

@injectable
class AuthViewModel extends HydratedCubit<AuthStates> {
  final AuthUseCase useCase;

  AuthViewModel({required this.useCase}) : super(AuthInitialState());

  String? _readNullableString(Map<String, dynamic> json, String key) {
    final value = json[key];
    return value?.toString();
  }

  AuthUserEntity? _readUser(Map<String, dynamic> json) {
    final userJson = json['user'];
    if (userJson is Map<String, dynamic>) {
      return AuthUserEntity.fromJson(userJson);
    }
    return null;
  }

  /// Register a new user
  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());

    final result = await useCase.registerInvoke(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (response) {
        if (response.user != null && response.user!.uid != null) {
          emit(
            RegisterSuccessState(
              user: response.user!,
              uid: response.user!.uid!,
            ),
          );
        } else {
          emit(AuthErrorState(message: 'Registration failed'));
        }
      },
    );
  }

  /// Login user
  void login({required String email, required String password}) async {
    emit(AuthLoadingState());

    final result = await useCase.loginInvoke(email: email, password: password);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (response) {
        if (response.user != null && response.user!.uid != null) {
          emit(
            LoginSuccessState(user: response.user!, uid: response.user!.uid!),
          );
        } else {
          emit(AuthErrorState(message: 'Login failed'));
        }
      },
    );
  }

  /// Logout user
  void logout() async {
    emit(AuthLoadingState());

    final result = await useCase.logoutInvoke();

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (success) => emit(LogoutSuccessState()),
    );
  }

  /// Get current authenticated user
  void getCurrentUser() async {
    emit(AuthLoadingState());

    final result = await useCase.getCurrentUserInvoke();

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (user) => emit(AuthenticatedUserLoadedState(user: user)),
    );
  }

  /// Get current user ID
  void getCurrentUserId() async {
    final result = await useCase.getCurrentUserIdInvoke();

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (uid) => emit(CurrentUserIdLoadedState(uid: uid)),
    );
  }

  @override
  AuthStates? fromJson(Map<String, dynamic> json) {
    try {
      final stateType = _readNullableString(json, 'state');

      switch (stateType) {
        case 'login_success':
          final loginUser = _readUser(json);
          final loginUid = _readNullableString(json, 'uid');
          if (loginUser == null || loginUid == null || loginUid.isEmpty) {
            return AuthInitialState();
          }
          return LoginSuccessState(
            user: loginUser,
            uid: loginUid,
          );
        case 'register_success':
          final registerUser = _readUser(json);
          final registerUid = _readNullableString(json, 'uid');
          if (registerUser == null ||
              registerUid == null ||
              registerUid.isEmpty) {
            return AuthInitialState();
          }
          return RegisterSuccessState(
            user: registerUser,
            uid: registerUid,
          );
        case 'authenticated_user_loaded':
          return AuthenticatedUserLoadedState(
            user: _readUser(json),
          );
        case 'current_user_id_loaded':
          return CurrentUserIdLoadedState(uid: _readNullableString(json, 'uid'));
        case 'logout_success':
          return LogoutSuccessState();
        case 'error':
          return AuthErrorState(
            message:
                _readNullableString(json, 'message') ??
                'Authentication error',
          );
        default:
          return AuthInitialState();
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthStates state) {
    try {
      if (state is LoginSuccessState) {
        return {
          'state': 'login_success',
          'user': state.user.toJson(),
          'uid': state.uid,
        };
      } else if (state is RegisterSuccessState) {
        return {
          'state': 'register_success',
          'user': state.user.toJson(),
          'uid': state.uid,
        };
      } else if (state is AuthenticatedUserLoadedState) {
        return {
          'state': 'authenticated_user_loaded',
          'user': state.user?.toJson(),
        };
      } else if (state is CurrentUserIdLoadedState) {
        return {'state': 'current_user_id_loaded', 'uid': state.uid};
      } else if (state is LogoutSuccessState) {
        return {'state': 'logout_success'};
      } else if (state is AuthErrorState) {
        return {'state': 'error', 'message': state.message};
      } else if (state is AuthLoadingState) {
        return {'state': 'loading'};
      }
      return {'state': 'initial'};
    } catch (e) {
      return null;
    }
  }
}

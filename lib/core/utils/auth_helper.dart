import '../di/di.dart';
import '../../features/auth/Domain/Use Case/auth_use_case.dart';

/// Helper class for authentication operations across the app
class AuthHelper {
  AuthHelper._(); // Private constructor

  /// Get current user ID synchronously from local storage
  static String? getCurrentUserIdSync() {
    // This uses the shared preferences service directly
    // which is already initialized in main.dart
    final authUseCase = getIt<AuthUseCase>();
    String? userId;
    
    authUseCase.getCurrentUserIdInvoke().then((result) {
      result.fold(
        (failure) => userId = null,
        (uid) => userId = uid,
      );
    });
    
    return userId;
  }

  /// Get current user ID asynchronously
  static Future<String?> getCurrentUserId() async {
    final authUseCase = getIt<AuthUseCase>();
    final result = await authUseCase.getCurrentUserIdInvoke();
    
    return result.fold(
      (failure) => null,
      (uid) => uid,
    );
  }

  /// Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final userId = await getCurrentUserId();
    return userId != null && userId.isNotEmpty;
  }
}

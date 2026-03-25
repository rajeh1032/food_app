import 'package:firebase_auth/firebase_auth.dart';

/// Utility class for mapping Firebase errors to user-friendly messages
class FirebaseErrorMapper {
  FirebaseErrorMapper._(); // Private constructor to prevent instantiation

  /// Map Firebase Auth errors to user-friendly Arabic/English messages
  static String mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'operation-not-allowed':
        return 'This operation is not allowed';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please login again';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials';
      case 'invalid-verification-code':
        return 'Invalid verification code';
      case 'invalid-verification-id':
        return 'Invalid verification ID';
      case 'expired-action-code':
        return 'The action code has expired';
      case 'invalid-action-code':
        return 'The action code is invalid';
      default:
        return e.message ?? 'Authentication failed';
    }
  }

  /// Map Firestore errors to user-friendly messages
  static String mapFirestoreError(Exception e) {
    final errorMessage = e.toString().toLowerCase();

    if (errorMessage.contains('permission-denied')) {
      return 'You do not have permission to perform this action';
    } else if (errorMessage.contains('not-found')) {
      return 'The requested document was not found';
    } else if (errorMessage.contains('already-exists')) {
      return 'This document already exists';
    } else if (errorMessage.contains('unavailable')) {
      return 'Service is currently unavailable. Please try again later';
    } else if (errorMessage.contains('deadline-exceeded')) {
      return 'Request timeout. Please check your connection';
    } else if (errorMessage.contains('network')) {
      return 'Network error. Please check your connection';
    }

    return 'An error occurred. Please try again';
  }
}

/// Form validation utilities
class AppValidators {
  AppValidators._(); // Private constructor to prevent instantiation

  /// Validate email format
  static String? validateEmail(String? val) {
    RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (val == null || val.trim().isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(val)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Validate password strength
  static String? validatePassword(String? val) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
    if (val == null || val.isEmpty) {
      return 'Password is required';
    } else if (val.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!passwordRegex.hasMatch(val)) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  /// Validate required field
  static String? validateRequired(
    String? val, {
    String fieldName = 'This field',
  }) {
    if (val == null || val.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate phone number
  static String? validatePhone(String? val) {
    RegExp phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (val == null || val.trim().isEmpty) {
      return 'Phone number is required';
    } else if (!phoneRegex.hasMatch(
      val.replaceAll(RegExp(r'[\s\-\(\)]'), ''),
    )) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Validate minimum length
  static String? validateMinLength(
    String? val,
    int minLength, {
    String fieldName = 'This field',
  }) {
    if (val == null || val.isEmpty) {
      return '$fieldName is required';
    } else if (val.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(
    String? val,
    int maxLength, {
    String fieldName = 'This field',
  }) {
    if (val != null && val.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }
    return null;
  }
}

/// Base class for all failure types in the application
abstract class Failures {
  final String errorMessage;

  Failures({required this.errorMessage});
}

/// Represents server-side errors (4xx, 5xx responses)
class ServerError extends Failures {
  ServerError({required super.errorMessage});
}

/// Represents network connectivity errors
class NetworkError extends Failures {
  NetworkError({required super.errorMessage});
}

/// Represents data parsing/serialization errors
class ParsingError extends Failures {
  ParsingError({required super.errorMessage});
}

/// Represents authentication/authorization errors
class AuthError extends Failures {
  AuthError({required super.errorMessage});
}

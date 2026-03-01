class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message, code: 'NETWORK_ERROR');
}

class ServerException extends AppException {
  ServerException(String message) : super(message, code: 'SERVER_ERROR');
}

class AuthException extends AppException {
  AuthException(String message) : super(message, code: 'AUTH_ERROR');
}

class ValidationException extends AppException {
  ValidationException(String message) : super(message, code: 'VALIDATION_ERROR');
}

class NotFoundException extends AppException {
  NotFoundException(String message) : super(message, code: 'NOT_FOUND');
}

class PermissionException extends AppException {
  PermissionException(String message) : super(message, code: 'PERMISSION_DENIED');
}
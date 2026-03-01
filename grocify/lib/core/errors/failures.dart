abstract class Failure {
  final String message;

  Failure(this.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class AuthFailure extends Failure {
  AuthFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  ValidationFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}

class UnknownFailure extends Failure {
  UnknownFailure(String message) : super(message);
}
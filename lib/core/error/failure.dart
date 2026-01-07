class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occurred']);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server error occurred']);
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message = 'No internet connection']);
}

class ValidationFailure extends Failure {
  ValidationFailure([super.message = 'Validation failed']);
}

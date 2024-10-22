class ApiExceptions implements Exception {
  final dynamic message;
  final dynamic prefix;

  ApiExceptions({
    required this.message,
    required this.prefix,
  });
  @override
  String toString() {
    return '$message';
  }
}

class ProfileInactiveException extends ApiExceptions {
  ProfileInactiveException([String? message])
      : super(
          message: message.toString(),
          prefix: 'Profile is Inactive',
        );
}

class FetechDataException extends ApiExceptions {
  FetechDataException([String? message])
      : super(
          message: message.toString(),
          prefix: 'Error During Communication',
        );
}

class BadRequestException extends ApiExceptions {
  BadRequestException([String? message])
      : super(
          message: message,
          prefix: 'Invalid Request',
        );
}

class NoContentException extends ApiExceptions {
  NoContentException([String? message])
      : super(
          message: message.toString(),
          prefix: 'No Content ',
        );
}

class UnauthorisedException extends ApiExceptions {
  UnauthorisedException([String? message])
      : super(
          message: message.toString(),
          prefix: 'Unauthorized Request',
        );
}

class UnauthenticatedException extends ApiExceptions {
  UnauthenticatedException([String? message])
      : super(
          message: message.toString(),
          prefix: 'Unauthenticated',
        );
}

class InvalidInputException extends ApiExceptions {
  InvalidInputException([String? message])
      : super(
          message: message.toString(),
          prefix: 'Invalid Input',
        );
}

class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ForbiddenException implements Exception {
  final String message;

  ForbiddenException(this.message);

  @override
  String toString() {
    return 'ForbiddenException: $message';
  }
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}

class RequestTimedOutException implements Exception {}

class ServerErrorException implements Exception {
  final String message;

  ServerErrorException(this.message);
  @override
  String toString() {
    return 'ServerErrorException: $message';
  }
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() {
    return message;
  }
}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);
  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException({this.message = '', this.statusCode});

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  const CacheException({this.message = ''});
}

class NetworkException implements Exception {
  final String message;
  const NetworkException({this.message = 'No internet connection'});
}

class AuthException implements Exception {
  final String message;
  const AuthException({this.message = 'Authentication failed'});
}

class ValidationException implements Exception {
  final Map<String, String>? errors;
  const ValidationException({this.errors});
}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException({this.message = ''});
}

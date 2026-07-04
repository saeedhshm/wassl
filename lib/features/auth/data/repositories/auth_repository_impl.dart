import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/data/datasource/auth_data_sources.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';
import 'package:wassl/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(email, password);
      if (response.token?.accessToken != null) {
        await _localDataSource.saveToken(response.token!.accessToken!);
      }
      return success(response);
    } on Exception catch (e) {
      return failure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _localDataSource.clearCredentials();
      return success(null);
    } on Exception catch (e) {
      return failure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(currentPassword, newPassword, confirmPassword);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> updateFcmToken(String token) async {
    try {
      await _remoteDataSource.updateFcmToken(token);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<UserEntity>> getCurrentUser() async {
    return success(UserEntity(
      id: 0,
      fullName: '',
      fullNameEn: '',
    ));
  }

  @override
  Future<Result<void>> saveCredentials(String email, String password) async {
    try {
      await _localDataSource.saveCredentials(email, password);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Map<String, String>>> getSavedCredentials() async {
    try {
      final creds = await _localDataSource.getSavedCredentials();
      return success(creds);
    } on Exception catch (e) {
      return failure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> clearCredentials() async {
    try {
      await _localDataSource.clearCredentials();
      return success(null);
    } on Exception catch (e) {
      return failure(_mapExceptionToFailure(e));
    }
  }

  @override
  Stream<bool> get authStateChanges => Stream.value(_localDataSource.getToken() != null);

  @override
  bool get isAuthenticated => _localDataSource.getToken() != null;

  @override
  String? get authToken => _localDataSource.getToken();

  @override
  String? get currentUserId => null;

  Failure _mapExceptionToFailure(Exception e) {
    if (e is ServerException) {
      return ServerFailure(e.message);
    } else if (e is NetworkException) {
      return NetworkFailure();
    } else if (e is AuthException) {
      return AuthFailure(e.message);
    }
    return UnexpectedFailure(e.toString());
  }
}

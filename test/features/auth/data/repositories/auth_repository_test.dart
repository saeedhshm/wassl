import 'package:flutter_test/flutter_test.dart';
import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/data/datasource/auth_data_sources.dart';
import 'package:wassl/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:wassl/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';

class MockAuthRemoteDataSourceForTest implements AuthRemoteDataSource {
  final bool shouldSucceed;

  MockAuthRemoteDataSourceForTest({this.shouldSucceed = true});

  @override
  Future<LoginResponseEntity> login(String email, String password) async {
    if (shouldSucceed) {
      return LoginResponseEntity(
        success: true,
        token: TokenEntity(accessToken: 'mock_token_123'),
        user: UserEntity(id: 1, fullName: 'Test', fullNameEn: 'Test'),
      );
    }
    throw ServerException(message: 'Invalid credentials', statusCode: 401);
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> changePassword(String currentPassword, String newPassword, String confirmPassword) async {}

  @override
  Future<void> updateFcmToken(String token) async {}
}

class MockAuthLocalDataSourceForTest implements AuthLocalDataSource {
  @override
  Future<void> saveCredentials(String email, String password) async {}

  @override
  Future<Map<String, String>> getSavedCredentials() async => {'email': 'test@test.com', 'password': '123456'};

  @override
  Future<void> clearCredentials() async {}

  @override
  Future<void> saveToken(String token) async {}

  @override
  String? getToken() => null;

  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {}

  @override
  Map<String, dynamic>? getUserData() => null;

  @override
  Future<void> clearAll() async {}
}

class MockAuthRepoForRepoTest extends AuthRepositoryImpl {
  MockAuthRepoForRepoTest(super.remoteDataSource, super.localDataSource);
}

void main() {
  group('AuthRepositoryImpl — login', () {
    test('returns LoginResponseEntity on success', () async {
      final repo = AuthRepositoryImpl(
        MockAuthRemoteDataSourceForTest(shouldSucceed: true),
        MockAuthLocalDataSourceForTest(),
      );
      final result = await repo.login(email: 'test@test.com', password: '123456');
      expect(result.failure, isNull);
      expect(result.data, isNotNull);
      expect(result.data!.token?.accessToken, 'mock_token_123');
    });

    test('returns ServerFailure on error', () async {
      final repo = AuthRepositoryImpl(
        MockAuthRemoteDataSourceForTest(shouldSucceed: false),
        MockAuthLocalDataSourceForTest(),
      );
      final result = await repo.login(email: 'test@test.com', password: 'wrong');
      expect(result.data, isNull);
      expect(result.failure, isA<ServerFailure>());
    });

    test('logout succeeds', () async {
      final repo = AuthRepositoryImpl(
        MockAuthRemoteDataSourceForTest(shouldSucceed: true),
        MockAuthLocalDataSourceForTest(),
      );
      final result = await repo.logout();
      expect(result.failure, isNull);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';
import 'package:wassl/features/auth/domain/repositories/auth_repository.dart';
import 'package:wassl/features/auth/domain/usecases/auth_usecases.dart';

class MockAuthRepository implements AuthRepository {
  final bool shouldSucceed;

  MockAuthRepository({this.shouldSucceed = true});

  @override
  Future<Result<LoginResponseEntity>> login({required String email, required String password}) async {
    if (shouldSucceed) {
      return success(LoginResponseEntity(
        success: true,
        token: TokenEntity(accessToken: 'test_token'),
        user: UserEntity(id: 1, fullName: 'Test', fullNameEn: 'Test'),
      ));
    }
    return failure(const ServerFailure('Invalid credentials'));
  }

  @override
  Future<Result<void>> logout() async => success(null);

  @override
  Future<Result<void>> changePassword({required String currentPassword, required String newPassword, required String confirmPassword}) async {
    if (shouldSucceed) return success(null);
    return failure(const ServerFailure('Password change failed'));
  }

  @override
  Future<Result<UserEntity>> getCurrentUser() async => success(UserEntity(id: 1, fullName: 'Test', fullNameEn: 'Test'));

  @override
  Future<Result<void>> saveCredentials(String email, String password) async => success(null);

  @override
  Future<Result<Map<String, String>>> getSavedCredentials() async => success({'email': 'test@test.com', 'password': '123456'});

  @override
  Future<Result<void>> clearCredentials() async => success(null);

  @override
  Future<Result<void>> updateFcmToken(String token) async => success(null);

  @override
  Stream<bool> get authStateChanges => const Stream.empty();

  @override
  bool get isAuthenticated => shouldSucceed;

  @override
  String? get authToken => 'test_token';

  @override
  String? get currentUserId => '1';
}

void main() {
  group('LoginUseCase', () {
    test('returns LoginResponseEntity on success', () async {
      final useCase = LoginUseCase(MockAuthRepository(shouldSucceed: true));
      final result = await useCase(email: 'test@test.com', password: '123456');
      expect(result.failure, isNull);
      expect(result.data, isNotNull);
      expect(result.data!.token?.accessToken, 'test_token');
    });

    test('returns Failure on error', () async {
      final useCase = LoginUseCase(MockAuthRepository(shouldSucceed: false));
      final result = await useCase(email: 'test@test.com', password: 'wrong!');
      expect(result.data, isNull);
      expect(result.failure, isA<ServerFailure>());
    });
  });

  group('LogoutUseCase', () {
    test('succeeds', () async {
      final useCase = LogoutUseCase(MockAuthRepository());
      final result = await useCase();
      expect(result.failure, isNull);
    });
  });

  group('ChangePasswordUseCase', () {
    test('succeeds with valid passwords', () async {
      final useCase = ChangePasswordUseCase(MockAuthRepository(shouldSucceed: true));
      final result = await useCase(currentPassword: 'old', newPassword: 'new123', confirmPassword: 'new123');
      expect(result.failure, isNull);
    });

    test('fails when new password is too short', () async {
      final useCase = ChangePasswordUseCase(MockAuthRepository());
      final result = await useCase(currentPassword: 'old', newPassword: 'ab', confirmPassword: 'ab');
      expect(result.failure, isA<ValidationFailure>());
    });

    test('fails when passwords do not match', () async {
      final useCase = ChangePasswordUseCase(MockAuthRepository());
      final result = await useCase(currentPassword: 'old', newPassword: 'new123', confirmPassword: 'different');
      expect(result.failure, isA<ValidationFailure>());
    });
  });
}

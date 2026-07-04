import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';
import 'package:wassl/features/auth/domain/repositories/auth_repository.dart';
import 'package:wassl/features/auth/domain/usecases/auth_usecases.dart';
import 'package:wassl/features/auth/presentation/cubit/auth_cubit.dart';

class MockAuthRepositoryCubit implements AuthRepository {
  @override
  Future<Result<LoginResponseEntity>> login({required String email, required String password}) async {
    if (email == 'fail@test.com') {
      return failure(const ServerFailure('Invalid credentials'));
    }
    return success(LoginResponseEntity(
      success: true,
      token: TokenEntity(accessToken: 'test_token'),
      user: UserEntity(id: 1, fullName: 'Test', fullNameEn: 'Test'),
    ));
  }

  @override
  Future<Result<void>> logout() async => success(null);

  @override
  Future<Result<void>> changePassword({required String currentPassword, required String newPassword, required String confirmPassword}) async => success(null);

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
  bool get isAuthenticated => true;

  @override
  String? get authToken => 'test_token';

  @override
  String? get currentUserId => '1';
}

AuthCubit buildCubit() {
  final repo = MockAuthRepositoryCubit();
  return AuthCubit(
    loginUseCase: LoginUseCase(repo),
    logoutUseCase: LogoutUseCase(repo),
    changePasswordUseCase: ChangePasswordUseCase(repo),
    getCurrentUserUseCase: GetCurrentUserUseCase(repo),
    saveCredentialsUseCase: SaveCredentialsUseCase(repo),
  );
}

void main() {
  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits AuthInitial initially',
      build: buildCubit,
      expect: () => [],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] on successful login',
      build: buildCubit,
      act: (cubit) => cubit.login(email: 'test@test.com', password: '1234567'),
      expect: () => [isA<AuthLoading>(), isA<AuthAuthenticated>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] on failed login',
      build: buildCubit,
      act: (cubit) => cubit.login(email: 'fail@test.com', password: 'wrong'),
      expect: () => [isA<AuthLoading>(), isA<AuthError>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthUnauthenticated] on logout',
      build: buildCubit,
      act: (cubit) => cubit.logout(),
      expect: () => [isA<AuthLoading>(), isA<AuthUnauthenticated>()],
    );
  });
}

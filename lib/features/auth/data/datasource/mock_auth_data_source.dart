import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/features/auth/data/datasource/auth_data_sources.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<LoginResponseEntity> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email == 'test@waslhr.com' && password == '1234567') {
      return LoginResponseEntity(
        success: true,
        token: TokenEntity(
          accessToken: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
          tokenType: 'Bearer',
          expiresIn: 3600,
        ),
        user: UserEntity(
          id: 1,
          code: 'EMP001',
          fullName: 'Test User',
          fullNameEn: 'Test User',
          email: 'test@waslhr.com',
          salary: '15000',
          isExemptFingerprinting: 0,
        ),
      );
    }
    throw ServerException(message: 'Invalid credentials', statusCode: 401);
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updateFcmToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}

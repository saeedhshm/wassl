import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';

abstract class AuthRepository {
  Future<Result<LoginResponseEntity>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> logout();

  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Result<void>> updateFcmToken(String token);

  Future<Result<UserEntity>> getCurrentUser();

  Future<Result<void>> saveCredentials(String email, String password);

  Future<Result<Map<String, String>>> getSavedCredentials();

  Future<Result<void>> clearCredentials();

  Stream<bool> get authStateChanges;

  bool get isAuthenticated;

  String? get authToken;

  String? get currentUserId;
}

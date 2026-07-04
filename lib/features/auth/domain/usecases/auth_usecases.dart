import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';
import 'package:wassl/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Result<LoginResponseEntity>> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      return failure(const ValidationFailure('Email is required'));
    }
    if (password.isEmpty) {
      return failure(const ValidationFailure('Password is required'));
    }
    if (password.length < 6) {
      return failure(const ValidationFailure('Password must be at least 6 characters'));
    }
    return _repository.login(email: email, password: password);
  }
}

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Result<void>> call() => _repository.logout();
}

class ChangePasswordUseCase {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Result<void>> call({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (currentPassword.isEmpty) {
      return failure(const ValidationFailure('Current password is required'));
    }
    if (newPassword.length < 6) {
      return failure(const ValidationFailure('Password must be at least 6 characters'));
    }
    if (newPassword != confirmPassword) {
      return failure(const ValidationFailure('Passwords do not match'));
    }
    return _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<Result<UserEntity>> call() => _repository.getCurrentUser();
}

class SaveCredentialsUseCase {
  final AuthRepository _repository;

  SaveCredentialsUseCase(this._repository);

  Future<Result<void>> call(String email, String password) =>
      _repository.saveCredentials(email, password);
}

class GetSavedCredentialsUseCase {
  final AuthRepository _repository;

  GetSavedCredentialsUseCase(this._repository);

  Future<Result<Map<String, String>>> call() => _repository.getSavedCredentials();
}

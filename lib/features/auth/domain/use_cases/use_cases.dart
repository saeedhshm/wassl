import 'package:dartz/dartz.dart';
import 'package:wassl/features/auth/domain/repositories/auth_repository.dart';

import '../../../../helpers/errors/failures.dart';

class LoginAuthUseCase {
  final AuthRepository repository;
  const LoginAuthUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.login();
  }
}

class ChangePasswordAuthUseCase {
  final AuthRepository repository;
  const ChangePasswordAuthUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
      {required String oldPassword,
      required String newPassword,
      required String bearer}) async {
    return await repository.changePassword(
        oldPassword: oldPassword, newPassword: newPassword, bearer: bearer);
  }
}

class LogoutAuthUseCase {
  final AuthRepository repository;
  const LogoutAuthUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}

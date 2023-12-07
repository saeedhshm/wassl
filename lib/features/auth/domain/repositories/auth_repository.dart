import 'package:dartz/dartz.dart';
import 'package:wassl/helpers/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String bearer});
  Future<Either<Failure, Unit>> login();
  Future<Either<Failure, Unit>> logout();
}

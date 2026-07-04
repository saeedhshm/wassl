import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';

abstract class ProfileRepository {
  Future<Result<UserEntity>> getProfile();
  Future<Result<void>> updateProfile(Map<String, dynamic> data);
}

import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';
import 'package:wassl/features/profile/data/datasource/profile_data_sources.dart';
import 'package:wassl/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<Result<UserEntity>> getProfile() async {
    return success(UserEntity(id: 0, fullName: '', fullNameEn: ''));
  }

  @override
  Future<Result<void>> updateProfile(Map<String, dynamic> data) async {
    try {
      await _dataSource.updateProfile(data);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  Failure _mapException(Exception e) {
    if (e is ServerException) return ServerFailure(e.message);
    if (e is NetworkException) return const NetworkFailure();
    return UnexpectedFailure(e.toString());
  }
}

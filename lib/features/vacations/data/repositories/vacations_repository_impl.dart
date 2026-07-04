import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/vacations/data/datasource/vacations_data_sources.dart';
import 'package:wassl/features/vacations/domain/repositories/vacations_repository.dart';

class VacationsRepositoryImpl implements VacationsRepository {
  final VacationsRemoteDataSource _dataSource;

  VacationsRepositoryImpl(this._dataSource);

  @override
  Future<Result<VacationsEntity>> getVacations() async {
    try {
      return success(await _dataSource.getVacations());
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

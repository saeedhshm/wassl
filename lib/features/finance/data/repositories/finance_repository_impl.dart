import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/finance/data/datasource/finance_data_sources.dart';
import 'package:wassl/features/finance/domain/entities/finance_entities.dart';
import 'package:wassl/features/finance/domain/repositories/finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceRemoteDataSource _dataSource;

  FinanceRepositoryImpl(this._dataSource);

  @override
  Future<Result<FinanceEntity>> getSalaryDetails({String? month, String? year}) async {
    try {
      final salaries = await _dataSource.getSalaryDetails(month: month, year: year);
      return success(FinanceEntity(salaries: salaries));
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<List<SalaryEntity>>> getSalaryMonths({String? month, String? year}) async {
    try {
      final salaries = await _dataSource.getSalaryMonths(month: month, year: year);
      return success(salaries);
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

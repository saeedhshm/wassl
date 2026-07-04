import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/finance/domain/entities/finance_entities.dart';

abstract class FinanceRepository {
  Future<Result<FinanceEntity>> getSalaryDetails({String? month, String? year});
  Future<Result<List<SalaryEntity>>> getSalaryMonths({String? month, String? year});
}

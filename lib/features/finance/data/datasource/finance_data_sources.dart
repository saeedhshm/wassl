import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/finance/domain/entities/finance_entities.dart';

abstract class FinanceRemoteDataSource {
  Future<List<SalaryEntity>> getSalaryDetails({String? month, String? year});
  Future<List<SalaryEntity>> getSalaryMonths({String? month, String? year});
}

class FinanceRemoteDataSourceImpl implements FinanceRemoteDataSource {
  final ApiClient _apiClient;

  FinanceRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<SalaryEntity>> getSalaryDetails({String? month, String? year}) async {
    final response = await _apiClient.get(ApiEndpoints.salaryDetails, queryParameters: {
      if (month != null) 'month': month,
      if (year != null) 'year': year,
    });
    return _parseSalaries(response.data);
  }

  @override
  Future<List<SalaryEntity>> getSalaryMonths({String? month, String? year}) async {
    final response = await _apiClient.get(ApiEndpoints.salaryMonths, queryParameters: {
      if (month != null) 'month': month,
      if (year != null) 'year': year,
    });
    return _parseSalaries(response.data);
  }

  List<SalaryEntity> _parseSalaries(dynamic responseData) {
    if (responseData is List) {
      return responseData.map((e) => SalaryEntity(
        id: e['id'] as int?,
        month: e['_month']?.toString(),
        salary: e['salary']?.toString(),
        salaryAfter: e['salary_after']?.toString(),
      )).toList();
    }
    return [];
  }
}

class MockFinanceRemoteDataSource implements FinanceRemoteDataSource {
  @override
  Future<List<SalaryEntity>> getSalaryDetails({String? month, String? year}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      SalaryEntity(id: 1, month: 'January', salary: '15000', salaryAfter: '15000'),
    ];
  }

  @override
  Future<List<SalaryEntity>> getSalaryMonths({String? month, String? year}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      SalaryEntity(id: 1, month: 'January', salary: '15000', salaryAfter: '14000'),
      SalaryEntity(id: 2, month: 'February', salary: '15000', salaryAfter: '14500'),
    ];
  }
}

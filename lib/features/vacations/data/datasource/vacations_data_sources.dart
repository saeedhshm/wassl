import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/vacations/domain/repositories/vacations_repository.dart';

abstract class VacationsRemoteDataSource {
  Future<VacationsEntity> getVacations();
}

class VacationsRemoteDataSourceImpl implements VacationsRemoteDataSource {
  final ApiClient _apiClient;

  VacationsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<VacationsEntity> getVacations() async {
    final response = await _apiClient.get(ApiEndpoints.getVacations);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>?;
      return VacationsEntity(
        balance: data != null ? VacationBalanceEntity(
          openingVacationsCount: data['opening_vacations_count']?.toString(),
          usedVacationsCount: data['used_vacations_count']?.toString(),
          availableVacationsCount: data['available_vacations_count']?.toString(),
          discountVacationsCount: data['discount_vacations_count']?.toString(),
          sickVacationsCount: data['sick_vacations_count']?.toString(),
          unpaidVacationsCount: data['unpaid_vacations_count']?.toString(),
        ) : null,
        incoming: (data?['next_vacations'] as List<dynamic>?)
            ?.map((e) => VacationHistoryEntity(
                  id: e['id'] as int?,
                  type: e['type']?['name']?.toString(),
                  holidayStart: e['holiday_start']?.toString(),
                  holidayEnd: e['holiday_end']?.toString(),
                  count: e['count'] as int?,
                  typeOfOrder: e['type_of_order']?.toString(),
                ))
            .toList(),
        previous: (data?['previous_vacations'] as List<dynamic>?)
            ?.map((e) => VacationHistoryEntity(
                  id: e['id'] as int?,
                  type: e['type']?['name']?.toString(),
                  holidayStart: e['holiday_start']?.toString(),
                  holidayEnd: e['holiday_end']?.toString(),
                  count: e['count'] as int?,
                  typeOfOrder: e['type_of_order']?.toString(),
                ))
            .toList(),
      );
    }
    throw ServerException(statusCode: response.statusCode);
  }
}

class MockVacationsRemoteDataSource implements VacationsRemoteDataSource {
  @override
  Future<VacationsEntity> getVacations() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return VacationsEntity(
      balance: VacationBalanceEntity(
        openingVacationsCount: '30',
        usedVacationsCount: '10',
        availableVacationsCount: '20',
        sickVacationsCount: '2',
        unpaidVacationsCount: '1',
      ),
      incoming: [
        VacationHistoryEntity(id: 1, type: 'Annual', holidayStart: '2026-07-01', holidayEnd: '2026-07-15', count: 15),
      ],
      previous: [
        VacationHistoryEntity(id: 2, type: 'Sick', holidayStart: '2026-03-01', holidayEnd: '2026-03-02', count: 2),
      ],
    );
  }
}

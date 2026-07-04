import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/attendance/domain/entities/attendance_entities.dart';

abstract class AttendanceRemoteDataSource {
  Future<MonthAttendanceEntity> getMonthAttendance({int? month, int? year});
  Future<List<TeamAttendanceEntity>> getTeamAttendance();
  Future<void> checkIn();
  Future<void> checkOut();
  Future<Map<String, dynamic>> checkStatus();
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient _apiClient;

  AttendanceRemoteDataSourceImpl(this._apiClient);

  @override
  Future<MonthAttendanceEntity> getMonthAttendance({int? month, int? year}) async {
    final response = await _apiClient.get(ApiEndpoints.monthlyAttendance, queryParameters: {
      if (month != null) 'month': month,
      if (year != null) 'year': year,
    });
    final json = response.data as Map<String, dynamic>? ?? {};
    return MonthAttendanceEntity(
      countWorkDaysAbsent: json['count_work_days_absent'] as int?,
      countWorkDaysAttend: json['count_work_days_attend'] as int?,
      lateAttendDaysCount: json['late_attend_days_count'] as int?,
      earlyLeaveDaysCount: json['early_leave_days_count'] as int?,
      missingLeaveDaysCount: json['missing_leave_days_count'] as int?,
      attendancesOfMonth: (json['attendances'] as List<dynamic>?)
          ?.map((e) => DayAttendanceEntity(
                day: e['day']?.toString(),
                status: e['status']?.toString(),
              ))
          .toList(),
    );
  }

  @override
  Future<List<TeamAttendanceEntity>> getTeamAttendance() async {
    final response = await _apiClient.get(ApiEndpoints.teamAttendance);
    final list = response.data as List<dynamic>? ?? [];
    return list.map((e) => TeamAttendanceEntity(
      id: e['id'] as int?,
      employeeId: e['employee_id'] as int?,
      employeeName: e['employee_name']?.toString(),
    )).toList();
  }

  @override
  Future<void> checkIn() async {
    await _apiClient.post(ApiEndpoints.registerAttendance);
  }

  @override
  Future<void> checkOut() async {
    await _apiClient.post(ApiEndpoints.registerLeaving);
  }

  @override
  Future<Map<String, dynamic>> checkStatus() async {
    final response = await _apiClient.get(ApiEndpoints.attendanceCheck);
    return response.data as Map<String, dynamic>? ?? {};
  }
}

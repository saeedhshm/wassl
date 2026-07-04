import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/attendance/data/datasource/attendance_data_sources.dart';
import 'package:wassl/features/attendance/domain/entities/attendance_entities.dart';

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient _apiClient;

  AttendanceRemoteDataSourceImpl(this._apiClient);

  @override
  Future<MonthAttendanceEntity> getMonthAttendance({int? month, int? year}) async {
    final now = DateTime.now();
    final url = '${ApiEndpoints.monthlyAttendance}?month=${month ?? now.month}&year=${year ?? now.year}';
    final response = await _apiClient.get(url);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      return _parseMonthAttendance(json);
    }
    throw ServerException(statusCode: response.statusCode);
  }

  @override
  Future<List<TeamAttendanceEntity>> getTeamAttendance() async {
    final response = await _apiClient.get(ApiEndpoints.teamAttendance);
    if (response.statusCode == 200) {
      final list = response.data as List<dynamic>;
      return list.map((e) => _parseTeamMember(e as Map<String, dynamic>)).toList();
    }
    throw ServerException(statusCode: response.statusCode);
  }

  @override
  Future<void> checkIn() async {
    final response = await _apiClient.post(ApiEndpoints.registerAttendance);
    if (response.statusCode != 200) {
      throw ServerException(statusCode: response.statusCode);
    }
  }

  @override
  Future<void> checkOut() async {
    final response = await _apiClient.post(ApiEndpoints.registerLeaving);
    if (response.statusCode != 200) {
      throw ServerException(statusCode: response.statusCode);
    }
  }

  @override
  Future<Map<String, dynamic>> checkStatus() async {
    final response = await _apiClient.get(ApiEndpoints.attendanceCheck);
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    throw ServerException(statusCode: response.statusCode);
  }

  MonthAttendanceEntity _parseMonthAttendance(Map<String, dynamic> json) {
    final totalAttendances = json['total_attendances'] as Map<String, dynamic>?;
    final attendancesList = (json['attendances_of_month'] as List<dynamic>?)
        ?.map((e) => _parseDayAttendance(e as Map<String, dynamic>))
        .toList();
    final todayList = (json['today_attendance'] as List<dynamic>?)
        ?.map((e) => TodayAttendanceEntity(
              message: e['message']?.toString(),
              attendanceStatus: e['attendance_status'] as int?,
            ))
        .toList();

    return MonthAttendanceEntity(
      totalAttendances: totalAttendances != null
          ? TotalAttendancesEntity(
              total: totalAttendances['total']?.toString(),
              totalAttendanceLateTime: totalAttendances['total_attendance_late_time']?.toString(),
              totalAttendanceOverTime: totalAttendances['total_attendance_over_time']?.toString(),
              totalLeaveEarlyTime: totalAttendances['total_leave_early_time']?.toString(),
              countWorkDays: totalAttendances['count_work_days'] as int?,
              countWorkHour: totalAttendances['count_work_hour'] as int?,
            )
          : null,
      countWorkDaysAbsent: json['_count_work_days_absent'] as int?,
      countWorkDaysAttend: json['_count_work_days_attend'] as int?,
      earlyLeaveDaysCount: json['early_leave_days_count'] as int?,
      lateAttendDaysCount: json['late_attend_days_count'] as int?,
      missingLeaveDaysCount: json['missing_leave_days_count'] as int?,
      attendancesOfMonth: attendancesList,
      todayAttendance: todayList,
    );
  }

  DayAttendanceEntity _parseDayAttendance(Map<String, dynamic> json) {
    final schedules = (json['schedules'] as List<dynamic>?)
        ?.map((s) => ScheduleEntity(
              message: s['message']?.toString(),
              attendanceStatus: s['attendance_status'] as int?,
              attendance: s['attendance'] != null
                  ? AttendanceEntity(
                      id: s['attendance']['id'] as int?,
                      userId: s['attendance']['user_id'] as int?,
                      attendanceTime: s['attendance']['attendance_time']?.toString(),
                      leaveTime: s['attendance']['leave_time']?.toString(),
                      attendanceStatus: s['attendance']['attendance_status'] as int?,
                    )
                  : null,
            ))
        .toList();

    return DayAttendanceEntity(
      day: json['day']?.toString(),
      status: json['_status']?.toString(),
      schedules: schedules,
    );
  }

  TeamAttendanceEntity _parseTeamMember(Map<String, dynamic> json) {
    final employee = json['employee'] as Map<String, dynamic>?;
    final attendances = (json['attendance'] as List<dynamic>?)
        ?.map((a) => AttendanceEntity(
              id: a['id'] as int?,
              userId: a['user_id'] as int?,
              attendanceTime: a['attendance_time']?.toString(),
              leaveTime: a['leave_time']?.toString(),
              attendanceStatus: a['attendance_status'] as int?,
            ))
        .toList();

    return TeamAttendanceEntity(
      id: json['id'] as int?,
      employeeId: json['employee_id'] as int?,
      employeeName: employee?['_full_name']?.toString(),
      employeeNameEn: employee?['_full_name_en']?.toString(),
      attendance: attendances,
    );
  }
}

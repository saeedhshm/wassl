import 'package:wassl/features/attendance/data/datasource/attendance_data_sources.dart';
import 'package:wassl/features/attendance/domain/entities/attendance_entities.dart';

class MockAttendanceRemoteDataSource implements AttendanceRemoteDataSource {
  @override
  Future<MonthAttendanceEntity> getMonthAttendance({int? month, int? year}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MonthAttendanceEntity(
      countWorkDaysAbsent: 2,
      countWorkDaysAttend: 20,
      lateAttendDaysCount: 1,
      earlyLeaveDaysCount: 1,
      missingLeaveDaysCount: 0,
      attendancesOfMonth: List.generate(30, (i) => DayAttendanceEntity(
        day: '${i + 1}',
        status: i < 20 ? 'attend' : 'absent',
      )),
    );
  }

  @override
  Future<List<TeamAttendanceEntity>> getTeamAttendance() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      TeamAttendanceEntity(id: 1, employeeId: 2, employeeName: 'Employee 1'),
      TeamAttendanceEntity(id: 2, employeeId: 3, employeeName: 'Employee 2'),
    ];
  }

  @override
  Future<void> checkIn() async => Future.delayed(const Duration(milliseconds: 300));

  @override
  Future<void> checkOut() async => Future.delayed(const Duration(milliseconds: 300));

  @override
  Future<Map<String, dynamic>> checkStatus() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {'attendance_status': 0};
  }
}

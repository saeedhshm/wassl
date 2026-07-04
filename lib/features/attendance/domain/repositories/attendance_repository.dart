import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/attendance/domain/entities/attendance_entities.dart';

abstract class AttendanceRepository {
  Future<Result<MonthAttendanceEntity>> getMonthAttendance({int? month, int? year});
  Future<Result<List<TeamAttendanceEntity>>> getTeamAttendance();
  Future<Result<void>> checkIn();
  Future<Result<void>> checkOut();
  Future<Result<Map<String, dynamic>>> checkStatus();
}

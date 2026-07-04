import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/attendance/data/datasource/attendance_data_sources.dart';
import 'package:wassl/features/attendance/domain/entities/attendance_entities.dart';
import 'package:wassl/features/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource _dataSource;

  AttendanceRepositoryImpl(this._dataSource);

  @override
  Future<Result<MonthAttendanceEntity>> getMonthAttendance({int? month, int? year}) async {
    try {
      final data = await _dataSource.getMonthAttendance(month: month, year: year);
      return success(data);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<List<TeamAttendanceEntity>>> getTeamAttendance() async {
    try {
      final data = await _dataSource.getTeamAttendance();
      return success(data);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<void>> checkIn() async {
    try {
      await _dataSource.checkIn();
      return success(null);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<void>> checkOut() async {
    try {
      await _dataSource.checkOut();
      return success(null);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> checkStatus() async {
    try {
      final data = await _dataSource.checkStatus();
      return success(data);
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

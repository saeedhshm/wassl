import 'package:dartz/dartz.dart' as dartz;
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/home/data/models/attendance_check.dart';
import 'package:wassl/features/home/domain/entities/home_entities.dart';
import 'package:wassl/helpers/errors/failures.dart' as old_failures;
import 'package:wassl/helpers/location/position.dart';

abstract class HomeRepository {
  Future<Result<HomeDataEntity>> getHomeData();
  Future<Result<List<AdEntity>>> getAds();
  Future<Result<List<EventEntity>>> getEvents();

  Future<dartz.Either<old_failures.Failure, dartz.Unit>> checkLocationPermission();
  Future<dartz.Either<old_failures.Failure, UserPosition>> getUserLocationPosition();
  Future<dartz.Either<old_failures.Failure, AttendanceCheck>> checkAttendanceStatus(Map<String, String> header);
  Future<dartz.Either<old_failures.Failure, dartz.Unit>> registerAttendanceLeave({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> header,
  });
}

import 'package:dartz/dartz.dart';
import 'package:wassl/helpers/errors/failures.dart';

import '../../../../helpers/location/position.dart';
import '../../data/models/attendance_check.dart';

abstract class HomeRepository {
  Future<Either<Failure, Unit>> checkLocationPermission();
  Future<Either<Failure, UserPosition>> getUserLocationPosition();

  Future<Either<Failure, AttendanceCheck>> checkAttendanceStatus(
      Map<String, String> header);

  Future<Either<Failure, Unit>> registerAttendanceLeave(
      {required String url,
      required Map<String, dynamic> body,
      required Map<String, String> header});
}

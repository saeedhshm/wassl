import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wassl/features/home/domain/repositories/home_repository.dart';
import 'package:wassl/helpers/errors/failures.dart';
import 'package:wassl/helpers/location/position.dart';

import '../../../../helpers/location/geolocation.dart';
import '../../../../helpers/permissions_handler/exceptions.dart';
import '../../../../helpers/permissions_handler/location_permission_handler.dart';
import 'location_failurs.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either<Failure, Unit>> checkLocationPermission() async {
    try {
      await LocationPermissionHandler().checkLocationPermission();
      return const Right(unit);
    } on SystemLocationDisabledException {
      return Left(SystemLocationDisabledFailure());
    } on LocationDeniedException {
      return Left(LocationDeniedFailure());
    } on LocationDeniedForeverException {
      return Left(LocationDeniedForeverFailure());
    }
  }

  @override
  Future<Either<Failure, UserPosition>> getUserLocationPosition() async {
    try {
      var position = await UserLocationPosition().getUserLocationPosition();
      return Right(position);
    } on TimeoutException {
      return Left(TimeoutFailure());
    } on LocationServiceDisabledException {
      return Left(LocationServiceDisabledFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> checkAttendanceStatus() {
    // TODO: implement checkAttendanceStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> registerAttendanceLeave() {
    // TODO: implement registerAttendanceLeave
    throw UnimplementedError();
  }
}

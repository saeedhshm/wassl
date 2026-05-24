import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wassl/core/error/failures.dart' as core_failures;
import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/home/data/data_sources/attendance_data_source.dart';
import 'package:wassl/features/home/data/datasource/home_data_sources.dart';
import 'package:wassl/features/home/domain/entities/home_entities.dart';
import 'package:wassl/features/home/domain/repositories/home_repository.dart';
import 'package:wassl/helpers/errors/failures.dart';
import 'package:wassl/helpers/location/position.dart';

import '../../../../helpers/exceptions/internet_api_exceptions.dart';
import '../../../../helpers/location/geolocation.dart';
import '../../../../helpers/permissions_handler/exceptions.dart';
import '../../../../helpers/permissions_handler/location_permission_handler.dart';
import '../models/attendance_check.dart';
import '../models/current_shift_retriever.dart';
import 'location_failurs.dart';

class HomeRepositoryImpl extends HomeRepository {
  final AttendanceDataSource dataSource = AttendanceDataSourceImpl();
  final HomeRemoteDataSource _homeDataSource;

  HomeRepositoryImpl({HomeRemoteDataSource? homeDataSource})
      : _homeDataSource = homeDataSource ?? _EmptyHomeDataSource();

  @override
  Future<Either<Failure, AttendanceCheck>> checkAttendanceStatus(
      Map<String, String> header) async {
    try {
      var checkList = await dataSource.checkAttendance(header);
      var currentShift = CurrentShiftRetriever.retrieveCurrentShift(checkList);
      return Right(currentShift!);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on NoDataAvailableException {
      return Left(NoDataFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

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
  Future<Either<Failure, Unit>> registerAttendanceLeave({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> header,
  }) async {
    try {
      await dataSource.registerAttendanceLeave(url: url, body: body, header: header);
      return const Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } catch (e) {
      return Left(UnknownFailure());
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
  Future<Result<HomeDataEntity>> getHomeData() async {
    try {
      final data = await _homeDataSource.getHomeData();
      return success(data);
    } on Exception catch (e) {
      return failure(core_failures.ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<AdEntity>>> getAds() async {
    try {
      final data = await _homeDataSource.getAds();
      return success(data);
    } on Exception catch (e) {
      return failure(core_failures.ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<EventEntity>>> getEvents() async {
    try {
      final data = await _homeDataSource.getEvents();
      return success(data);
    } on Exception catch (e) {
      return failure(core_failures.ServerFailure(e.toString()));
    }
  }
}

class _EmptyHomeDataSource implements HomeRemoteDataSource {
  @override
  Future<HomeDataEntity> getHomeData() async =>
      const HomeDataEntity();

  @override
  Future<List<AdEntity>> getAds() async => const [];

  @override
  Future<List<EventEntity>> getEvents() async => const [];
}

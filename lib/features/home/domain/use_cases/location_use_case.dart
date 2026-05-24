import 'package:dartz/dartz.dart';
import 'package:wassl/features/home/data/models/attendance_check.dart';
import 'package:wassl/features/home/domain/repositories/home_repository.dart';
import 'package:wassl/helpers/errors/failures.dart';
import 'package:wassl/helpers/location/position.dart';

class LocationUseCase {
  final HomeRepository homeRepository;

  LocationUseCase({required this.homeRepository});

  Future<Either<Failure, Unit>> checkLocationPermission() async {
    return await homeRepository.checkLocationPermission();
  }

  Future<Either<Failure, UserPosition>> getUserLocationPosition() async {
    return await homeRepository.getUserLocationPosition();
  }
}

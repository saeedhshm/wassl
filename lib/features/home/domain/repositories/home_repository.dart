import 'package:dartz/dartz.dart';
import 'package:wassl/helpers/errors/failures.dart';

import '../../../../helpers/location/position.dart';

abstract class HomeRepository {
  Future<Either<Failure, Unit>> checkLocationPermission();
  Future<Either<Failure, UserPosition>> getUserLocationPosition();
}

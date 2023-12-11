import 'package:wassl/helpers/errors/failures.dart';

/// Location permission Failures
class SystemLocationDisabledFailure extends Failure {}

class LocationDeniedFailure extends Failure {}

class LocationDeniedForeverFailure extends Failure {}

/// Location position Failures
class TimeoutFailure extends Failure {}

class LocationServiceDisabledFailure extends Failure {}

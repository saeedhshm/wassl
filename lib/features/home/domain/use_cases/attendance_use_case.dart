import 'package:dartz/dartz.dart';
import 'package:wassl/features/home/domain/repositories/home_repository.dart';

import '../../../../helpers/errors/failures.dart';
import '../../data/models/attendance_check.dart';

class AttendanceUseCases {
  final HomeRepository homeRepository;

  AttendanceUseCases({required this.homeRepository});

  Future<Either<Failure, AttendanceCheck>> checkAttendanceStatus(
      Map<String, String> header) async {
    return await homeRepository.checkAttendanceStatus(header);
  }

  Future<Either<Failure, Unit>> registerAttendanceLeave() async {
    throw UnimplementedError();
  }
}

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

  Future<Either<Failure, Unit>> registerAttendanceLeave(
      {required String url,
      required Map<String, dynamic> body,
      required Map<String, String> header}) async {
    return await homeRepository.registerAttendanceLeave(
        url: url, body: body, header: header);
  }
}

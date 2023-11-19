import 'package:wassl/helpers/extensions/strings_extensions.dart';

import '../attendance.dart';
import '../schedule.dart';

class AttendanceCheck {

  String? message;
  int? attendanceStatus;
  Attendance? attendance;
  dynamic vacation;
  Schedule? schedule;
  int? shiftIndex;


  AttendanceCheck();

  AttendanceCheck.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    attendanceStatus = json['attendance_status'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
    vacation = json['vacation'];
    schedule = json['schedule'] != null
        ? Schedule.fromJson(json['schedule'])
        : null;
  }



}




extension SecheduleTimes on AttendanceCheck{
  DateTime get empTimeIn{
    return (schedule?.info?.timeIn ?? '').exactDateTimeFromGivenHours!;
  }

  DateTime get empTimeOut{
    return (schedule?.info?.timeOut ?? '').exactDateTimeFromGivenHours!;
  }

  DateTime get empAllowTimeIn{

    return (schedule?.allowTimeIn ?? '').exactDateTimeFromGivenHours!;
  }

  DateTime get empAllowTimeOut{
    if(schedule?.allowTimeOut != null) {
      return (schedule?.allowTimeOut ?? '').exactDateTimeFromGivenHours!;
    }
    return empTimeOut.add(const Duration(minutes: 40));
  }
}


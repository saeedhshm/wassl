import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';

class AttendanceCheck {

  String? message;
  int? attendanceStatus;
  Attendance? attendance;
  dynamic vacation;
  Schedule? schedule;

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

class Schedule {
  int? id;
  int? employeeId;
  int? scheduleId;
  int? minuteTimeOut;
  int? minuteTimeIn;
  String? allowTimeOut;
  String? allowTimeIn;
  Info? info;

  Schedule();

  Schedule.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    minuteTimeOut = json['minute_time_out'];
    minuteTimeIn = json['minute_time_in'];
    allowTimeOut = json['allow_time_out'];
    allowTimeIn = json['allow_time_in'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  String get timeIn {
    return (info?.timeIn ?? '').formattedTime();
  }

  String get timeOut {
    return (info?.timeOut ?? '').formattedTime();
  }


}

class Info {
  int? id;
  int? companyId;
  int? type;
  String? slug;
  String? weekEndDays;
  String? timeIn;
  String? timeOut;

  Info(
      {this.id,
        this.companyId,
        this.type,
        this.slug,
        this.weekEndDays,
        this.timeIn,
        this.timeOut});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    type = json['type'];
    slug = json['slug'];
    weekEndDays = json['week_end_days'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
  }


}

class Attendance {
  int? id;
  int? userId;
  String? attendanceTime;
  dynamic attendanceOverTime;
  String? attendanceLateTime;
  int? attendanceStatus;
  dynamic leaveTime;
  dynamic leaveOverTime;
  dynamic leaveEarlyTime;
  dynamic leaveStatus;
  int? scheduleId;
  String? createdAt;
  String? updatedAt;

  Attendance();

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    attendanceTime = json['attendance_time'];
    attendanceOverTime = json['attendance_over_time'];
    attendanceLateTime = json['attendance_late_time'];
    attendanceStatus = json['attendance_status'];
    leaveTime = json['leave_time'];
    leaveOverTime = json['leave_over_time'];
    leaveEarlyTime = json['leave_early_time'];
    leaveStatus = json['leave_status'];
    scheduleId = json['schedule_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

extension SecheduleTimes on AttendanceCheck{
  DateTime get empTimeIn{
    return (schedule?.info?.timeIn ?? '').exactDateTimeFromGivenHours;
  }

  DateTime get empTimeOut{
    return (schedule?.info?.timeOut ?? '').exactDateTimeFromGivenHours;
  }

  DateTime get empAllowTimeIn{
    return (schedule?.allowTimeIn ?? '').exactDateTimeFromGivenHours;
  }

  DateTime get empAllowTimeOut{
    return (schedule?.allowTimeOut ?? '').exactDateTimeFromGivenHours;
  }
}


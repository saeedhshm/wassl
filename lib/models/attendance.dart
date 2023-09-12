import 'package:wassl/helpers/extensions/strings_extensions.dart';

class Attendance {


  int? id;
  int? userId;
  String? _attendanceTime;
  String? attendanceOverTime;
  String? attendanceLateTime;
  int? attendanceStatus;
  String? _leaveTime;
  dynamic leaveOverTime;
  String? leaveEarlyTime;
  int? leaveStatus;
  int? scheduleId;
  String? createdAt;
  String? updatedAt;
  String status = 'absent';

  Attendance();

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    _attendanceTime = json['attendance_time'];
    attendanceOverTime = json['attendance_over_time'];
    attendanceLateTime = json['attendance_late_time'];
    attendanceStatus = json['attendance_status'];
    _leaveTime = json['leave_time'];
    leaveOverTime = json['leave_over_time'];
    leaveEarlyTime = json['leave_early_time'];
    leaveStatus = json['leave_status'];
    scheduleId = json['schedule_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    status = _leaveTime == null ? 'missed_leave' : 'attend';
  }


  String get attendanceTime{
    var time = '----';
    if(_attendanceTime != null){
      time =  _attendanceTime?.split(' ')[1] ?? '----';
    }
    return time.formattedTime() ?? '---';
  }

  String get leaveTime{
    var time = '----';
    if(_leaveTime != null){
      time = _leaveTime?.split(' ')[1] ?? '.......';
    }
    return time.formattedTime() ?? '---';

  }

  DateTime? get empTimeIn{
    return (_attendanceTime ?? '').exactDateTimeFromGivenHours;
  }

  DateTime? get empTimeOut{
    return (_leaveTime ?? '').exactDateTimeFromGivenHours;
  }

}

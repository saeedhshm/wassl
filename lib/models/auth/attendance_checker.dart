class AttendanceChecker {
  String? message;
  int? attendanceStatus;
  Attendance? attendance;

  AttendanceChecker({message, attendanceStatus, attendance});

  AttendanceChecker.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    attendanceStatus = json['attendance_status'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['attendance_status'] = attendanceStatus;
    if (attendance != null) {
      data['attendance'] = attendance!.toJson();
    }
    return data;
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

  Attendance(
      {id,
        userId,
        attendanceTime,
        attendanceOverTime,
        attendanceLateTime,
        attendanceStatus,
        leaveTime,
        leaveOverTime,
        leaveEarlyTime,
        leaveStatus,
        scheduleId,
        createdAt,
        updatedAt});

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['attendance_time'] = attendanceTime;
    data['attendance_over_time'] = attendanceOverTime;
    data['attendance_late_time'] = attendanceLateTime;
    data['attendance_status'] = attendanceStatus;
    data['leave_time'] = leaveTime;
    data['leave_over_time'] = leaveOverTime;
    data['leave_early_time'] = leaveEarlyTime;
    data['leave_status'] = leaveStatus;
    data['schedule_id'] = scheduleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

import 'package:wassl/helpers/extensions/strings_extensions.dart';

class MonthAttendance {
  TotalAttendances? totalAttendances;
  List<MonthDay>? attendancesOfMonth;
  TodayAttendance? todayAttendance;
  Schedule? schedule;

  MonthAttendance(
      {this.totalAttendances,
        this.attendancesOfMonth,
        this.todayAttendance,
        this.schedule});

  MonthAttendance.fromJson(Map<String, dynamic> json) {
    totalAttendances = json['totalAttendances'] != null
        ? TotalAttendances.fromJson(json['totalAttendances'])
        : null;
    if (json['attendancesOfMonth'] != null) {
      attendancesOfMonth = <MonthDay>[];
      json['attendancesOfMonth'].forEach((v) {
        attendancesOfMonth!.add(MonthDay.fromJson(v));
      });
    }
    todayAttendance = json['todayAttendance'] != null
        ? TodayAttendance.fromJson(json['todayAttendance'])
        : null;
    schedule = json['schedule'] != null
        ? Schedule.fromJson(json['schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.totalAttendances != null) {
      data['totalAttendances'] = this.totalAttendances!.toJson();
    }
    if (this.attendancesOfMonth != null) {
      data['attendancesOfMonth'] =
          this.attendancesOfMonth!.map((v) => v.toJson()).toList();
    }
    if (this.todayAttendance != null) {
      data['todayAttendance'] = this.todayAttendance!.toJson();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.toJson();
    }
    return data;
  }
}

class TotalAttendances {
  String? total;
  String? totalAttendanceLateTime;
  String? totalAttendanceOverTime;
  String? totalLeaveEarlyTime;
  dynamic totalLeaveOverTime;
  int? countWorkDays;
  int? countWorkHour;

  TotalAttendances(
      {this.total,
        this.totalAttendanceLateTime,
        this.totalAttendanceOverTime,
        this.totalLeaveEarlyTime,
        this.totalLeaveOverTime,
        this.countWorkDays,
        this.countWorkHour});

  TotalAttendances.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalAttendanceLateTime = json['total_attendance_late_time'];
    totalAttendanceOverTime = json['total_attendance_over_time'];
    totalLeaveEarlyTime = json['total_leave_early_time'];
    totalLeaveOverTime = json['total_leave_over_time'];
    countWorkDays = json['countWorkDays'];
    countWorkHour = json['countWorkHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = this.total;
    data['total_attendance_late_time'] = totalAttendanceLateTime;
    data['total_attendance_over_time'] = totalAttendanceOverTime;
    data['total_leave_early_time'] = totalLeaveEarlyTime;
    data['total_leave_over_time'] = totalLeaveOverTime;
    data['countWorkDays'] = countWorkDays;
    data['countWorkHour'] = countWorkHour;
    return data;
  }
}

class MonthDay {
  String? day;
  String? status;
  AttendanceDay? attendanceDay;
  // var selected = false;

  String get attendanceTime{
    var time = '----';
    if(attendanceDay != null){
      time =  (attendanceDay?.attendanceTime ?? '').split(' ')[1];
    }
   return time.formatedTime();
  }

  String get leaveTime{
    var time = '----';
    if(attendanceDay != null){
      time = attendanceDay?.leaveTime == null ? (attendanceDay?.leaveTime ?? '.......') : (attendanceDay?.leaveTime ?? '.......').split(' ')[1] ;
    }
    return time.formatedTime();

  }

  MonthDay({this.day, this.status, this.attendanceDay});

  MonthDay.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    status = json['status'];
    attendanceDay = json['attendance'] != null
        ? AttendanceDay.fromJson(json['attendance'])
        : null;
    // // DateTime.tryParse(day.attendanceDay?.attendanceTime ?? '')
    // selected = ;
    // // selected = attendanceDay.
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = this.day;
    data['status'] = this.status;
    if (this.attendanceDay != null) {
      data['attendance'] = this.attendanceDay!.toJson();
    }
    return data;
  }
}

class AttendanceDay {
  int? id;
  int? userId;
  String? attendanceTime;
  String? attendanceOverTime;
  String? attendanceLateTime;
  int? attendanceStatus;
  String? leaveTime;
  dynamic leaveOverTime;
  String? leaveEarlyTime;
  int? leaveStatus;
  int? scheduleId;
  String? createdAt;
  String? updatedAt;

  AttendanceDay(
      {this.id,
        this.userId,
        this.attendanceTime,
        this.attendanceOverTime,
        this.attendanceLateTime,
        this.attendanceStatus,
        this.leaveTime,
        this.leaveOverTime,
        this.leaveEarlyTime,
        this.leaveStatus,
        this.scheduleId,
        this.createdAt,
        this.updatedAt});

  AttendanceDay.fromJson(Map<String, dynamic> json) {
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
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['attendance_time'] = this.attendanceTime;
    data['attendance_over_time'] = this.attendanceOverTime;
    data['attendance_late_time'] = this.attendanceLateTime;
    data['attendance_status'] = this.attendanceStatus;
    data['leave_time'] = this.leaveTime;
    data['leave_over_time'] = this.leaveOverTime;
    data['leave_early_time'] = this.leaveEarlyTime;
    data['leave_status'] = this.leaveStatus;
    data['schedule_id'] = this.scheduleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TodayAttendance {
  String? message;
  int? attendanceStatus;
  Attendance? attendance;

  TodayAttendance({this.message, this.attendanceStatus, this.attendance});

  TodayAttendance.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    attendanceStatus = json['attendance_status'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    data['attendance_status'] = this.attendanceStatus;
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.toJson();
    }
    return data;
  }
}

class Attendance {
  int? id;
  int? userId;
  String? attendanceTime;
  String? attendanceOverTime;
  dynamic attendanceLateTime;
  int? attendanceStatus;
  dynamic leaveTime;
  dynamic leaveOverTime;
  dynamic leaveEarlyTime;
  dynamic leaveStatus;
  int? scheduleId;
  String? createdAt;
  String? updatedAt;

  Attendance(
      {this.id,
        this.userId,
        this.attendanceTime,
        this.attendanceOverTime,
        this.attendanceLateTime,
        this.attendanceStatus,
        this.leaveTime,
        this.leaveOverTime,
        this.leaveEarlyTime,
        this.leaveStatus,
        this.scheduleId,
        this.createdAt,
        this.updatedAt});

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
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['attendance_time'] = this.attendanceTime;
    data['attendance_over_time'] = this.attendanceOverTime;
    data['attendance_late_time'] = this.attendanceLateTime;
    data['attendance_status'] = this.attendanceStatus;
    data['leave_time'] = this.leaveTime;
    data['leave_over_time'] = this.leaveOverTime;
    data['leave_early_time'] = this.leaveEarlyTime;
    data['leave_status'] = this.leaveStatus;
    data['schedule_id'] = this.scheduleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Schedule {
  int? id;
  int? companyId;
  String? nameAr;
  String? nameEn;
  String? slug;
  String? timeIn;
  String? timeOut;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  Schedule(
      {this.id,
        this.companyId,
        this.nameAr,
        this.nameEn,
        this.slug,
        this.timeIn,
        this.timeOut,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    slug = json['slug'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['slug'] = this.slug;
    data['time_in'] = this.timeIn;
    data['time_out'] = this.timeOut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? scheduleId;

  Pivot({this.userId, this.scheduleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    scheduleId = json['schedule_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = this.userId;
    data['schedule_id'] = this.scheduleId;
    return data;
  }
}

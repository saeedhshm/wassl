import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';

import '../attendance.dart';
import '../auth/attendance_check.dart';
import '../holidays/vacations.dart';
import '../orders/order_type.dart';
import '../schedule.dart';


class MonthAttendance {
  TotalAttendances? totalAttendances;
  int? _countWorkDaysAbsent;
  int? _countWorkDaysAttend;
  List<AttendancesOfMonth> attendancesOfMonth = [];
  List<TodayAttendance>? todayAttendance;
  MonthSchedule? schedule;

  MonthAttendance();

  MonthAttendance.fromJson(Map<String, dynamic> json) {


    _countWorkDaysAbsent = json['countWorkDaysAbsent'];
    _countWorkDaysAttend = json['countWorkDaysAttend'];

    totalAttendances = json['totalAttendances'] != null
        ? TotalAttendances.fromJson(json['totalAttendances'])
        : null;
    if (json['attendancesOfMonth'] != null) {
      attendancesOfMonth = <AttendancesOfMonth>[];
      json['attendancesOfMonth'].forEach((v) {
        attendancesOfMonth.add(AttendancesOfMonth.fromJson(v));
      });
    }
    if (json['todayAttendance'] != null) {
      todayAttendance = <TodayAttendance>[];
      if(json['todayAttendance'] is List){
        json['todayAttendance'].forEach((v) {
          todayAttendance!.add(TodayAttendance.fromJson(v));
        });
      }
    }
    schedule = json['schedule'] != null
        ? MonthSchedule.fromJson(json['schedule'])
        : null;
  }



  int get missedRecords {
    int sum = 0;

    // for(var item in attendancesOfMonth){
    //
    //   if(item.attendanceDay != null){
    //     if(item.attendanceDay?.leaveTime == null) {
    //       sum++;
    //     }
    //   }
    // }

    return sum;
  }

  int get countWorkDaysAbsent{
    return _countWorkDaysAbsent ?? 0;
  }

  int get earlyLeaveCount{
    int sum = 0;
    // for(var item in attendancesOfMonth){
    //
    //   if(item.attendanceDay != null){
    //     if(item.attendanceDay?.leaveEarlyTime != null) {
    //       sum++;
    //     }
    //   }
    // }
    return sum;
  }

  int get lateAttendance{
    int sum = 0;
    // for(var item in attendancesOfMonth){
    //
    //   if(item.attendanceDay != null){
    //     if(item.attendanceDay?.attendanceLateTime != null) {
    //       sum++;
    //     }
    //   }
    // }
    return sum;
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

class AttendancesOfMonth {


  dynamic holiday;
  Vacation? vacation;
  String? day;
  List<Attendance> _attendance = <Attendance>[];
  String? _status;

  // var selected = false;



  AttendancesOfMonth();

  AttendancesOfMonth.fromJson(Map<String, dynamic> json) {
    holiday = json['holiday'];
    vacation = json['vacation'] != null
        ? Vacation.fromJson(json['vacation'])
        : null;
    day = json['day'];
    if (json['attendance'] != null) {
      if(json['attendance'] is List){
        json['attendance'].forEach((v) {
          _attendance.add(Attendance.fromJson(v));
        });
      }
    }
    _status = json['status'];
  }

  String get status{
    var st = _status ?? '';
    if(st == 'attend'){
      for(var att in _attendance) {
        if(att.leaveTime.contains('----')){
          att.status = 'missed_leave';
      }
      }
    }

    return st;
  }

  List<Attendance> get attendance{
    _attendance.sort((a, b){
      if(a.empTimeIn != null && b.empTimeIn != null){
        return a.empTimeIn!.compareTo(b.empTimeIn!);
      }
      return -1;
    });

    return _attendance;
  }


}





class TodayAttendance {
  String? message;
  int? attendanceStatus;
  Attendance? attendance;
  Vacation? vacation;
  Schedule? schedule;

  TodayAttendance({this.message, this.attendanceStatus, this.attendance});

  TodayAttendance.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    attendanceStatus = json['attendance_status'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
    vacation = json['vacation'] != null
        ? Vacation.fromJson(json['vacation'])
        : null;
  }


}



class MonthSchedule {
  int? id;
  int? companyId;
  String? _nameAr;
  String? _nameEn;
  String? slug;
  String? timeIn;
  String? timeOut;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  MonthSchedule(
      {this.id,
        this.companyId,
        this.slug,
        this.timeIn,
        this.timeOut,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  MonthSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    _nameAr = json['name_ar'];
    _nameEn = json['name_en'];
    slug = json['slug'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  String get name {
    return ('lang_code'.tr == 'ar' ? _nameAr : _nameEn) ?? '';
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

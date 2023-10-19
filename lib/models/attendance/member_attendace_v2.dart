
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';

class TeamAttendanceV2{
  var teamAttendance = <MemberAttendance>[];

  TeamAttendanceV2();

  TeamAttendanceV2.fromJson(List json) {
    println('inside TeamAttendanceV2');
    for (var v in json) {

      teamAttendance.add(MemberAttendance.fromJson(v));
    }

  }
}

class MemberAttendance {
  int? id;
  int? employeeId;
  String? responsibleEmployeeId;
  List<Attendance> attendance = [];
  Employee? employee;

  MemberAttendance();

  MemberAttendance.fromJson(Map<String, dynamic> json) {
    println("inside MemberAttendance.fromJson");
    println(json);
    id = json['id'];
    employeeId = json['employee_id'];
    responsibleEmployeeId = json['responsible_employee_id'];

    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      if(json['attendance'] is List){
        json['attendance'].forEach((v) {
          attendance.add(Attendance.fromJson(v));
        });
      }else{
        var atten = json['attendance'] != null
            ? Attendance.fromJson(json['attendance'])
            : null;
        attendance.add(atten!);
      }

    }
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
  }


  bool get memberIsAbsent{
    if(attendance.length > 1){
      return (attendance.first.attendance == null && attendance.last.attendance == null);
    }
    return attendance.first.attendance == null && !attendance.first.isExempt;
  }


  String get fullName{
    var name = employee?.fullName ?? '';

    List<String> myStringList = name.split(' '); //Splitting the string where it finds an empty space;

    var n = '';

    if(myStringList.length < 4){
      return name;
    }

    for(int i = 0; i<3; i++){
      n += myStringList[i];
      if(i < 2){
        n += ' ';
      }
    }


    return n;
  }

  String get jobName{
    return employee?.job?.fullName ?? '';
  }

}

class Attendance {
  String? message;
  int? _attendanceStatus;
  AttendanceInfo? attendance;
  dynamic vacation;
  Schedule? schedule;

  Attendance();

  Attendance.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    _attendanceStatus = json['attendance_status'];
    attendance = json['attendance'] != null
        ? AttendanceInfo.fromJson(json['attendance'])
        : null;
    vacation = json['vacation'];
    schedule = json['schedule'] != null
        ? Schedule.fromJson(json['schedule'])
        : null;
  }

  bool get isExempt{
    return (_attendanceStatus ?? 0) == 4;
  }

  String get attendanceStatus{
    int status = (_attendanceStatus ?? 0) ;
    return  status == 0 ? 'holiday' : status == 1 ? 'no_attendance_assign' : status == 2 ? 'attendance_assign' : 'attendance_and_leave_assign';
  }


  String get attendanceTime{
    var time = 'missed'.tr;
    var attTime = attendance?.attendanceTime ?? '';

    if(attTime.length > 1) {
      time = attTime.split(' ')[1];
    }

    return time.formattedTime() ?? '---';

  }

  String get leaveTime{
    var time = 'missed'.tr;

    var attTime = attendance?.leaveTime ?? '';


    if(attTime.length > 1) {
      time = attTime.split(' ')[1];
    }

    return time.formattedTime() ?? '---';
  }

}

class AttendanceInfo {
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

  AttendanceInfo(
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

  AttendanceInfo.fromJson(Map<String, dynamic> json) {
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

class Schedule {
  int? id;
  int? employeeId;
  int? scheduleId;
  int? minuteTimeOut;
  int? minuteTimeIn;
  String? allowTimeOut;
  String? allowTimeIn;
  Info? info;

  Schedule(
      {this.id,
        this.employeeId,
        this.scheduleId,
        this.minuteTimeOut,
        this.minuteTimeIn,
        this.allowTimeOut,
        this.allowTimeIn,
        this.info});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    minuteTimeOut = json['minute_time_out'];
    minuteTimeIn = json['minute_time_in'];
    allowTimeOut = json['allow_time_out'];
    allowTimeIn = json['allow_time_in'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
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

class Employee {
  int? id;
  String? email;
  String? code;
  String? _fullName;
  String? _fullNameEn;
  int? jobId;
  Job? job;

  Employee();

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    code = json['code'];
    _fullName = json['full_name'];
    _fullNameEn = json['full_name_en'];
    jobId = json['job_id'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
  }

  String get fullName{
    return ('lang_code'.tr == 'ar' ?  _fullName : _fullNameEn) ?? '';
  }

}

class Job {
  int? id;
  int? companyId;
  String? _nameAr;
  String? _nameEn;
  String? createdAt;
  String? updatedAt;

  Job();

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    _nameAr = json['name_ar'];
    _nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String get fullName{
    return ('lang_code'.tr == 'ar' ?  _nameAr : _nameEn) ?? '';
  }

}

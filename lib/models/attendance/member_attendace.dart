
import 'package:get/get.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';

import '../../helpers/constants/print_ln.dart';

class TeamAttendance{
  var teamAttendance = <MemberAttendance>[];
  TeamAttendance();

  TeamAttendance.fromJson(List json) {

    for (var v in json) {

      teamAttendance.add(MemberAttendance.fromJson(v));
    }
  }
}

class MemberAttendance {
  int? id;
  int? employeeId;
  String? responsibleEmployeeId;
  Attendance? attendance;
  Employee? employee;

  MemberAttendance(
      {this.id,
        this.employeeId,
        this.responsibleEmployeeId,
        this.attendance,
        this.employee});

  MemberAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    responsibleEmployeeId = json['responsible_employee_id'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
  }

  String get attendanceTime{
    var time = 'missed'.tr;
    var attTime = attendance?.attendance?.attendanceTime ?? '';

    if(attTime.length > 1) {
      time = attTime.split(' ')[1];
    }

    return time.formattedTime();

  }

  String get leaveTime{
    var time = 'missed'.tr;
    var attTime = attendance?.attendance?.leaveTime ?? '';

    if(attTime.length > 1) {
      time = attTime.split(' ')[1];
    }

    return time.formattedTime();
  }

  String get fullName{
    var name = employee?.fullName ?? '';
    println(name);
    List<String> myStringList = name.split(' '); //Splitting the string where it finds an empty space;
    println(myStringList);
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
}

class Attendance {
  String? message;
  int? attendanceStatus;
  AttendanceInfo? attendance;

  Attendance({this.message, this.attendanceStatus, this.attendance});

  Attendance.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    attendanceStatus = json['attendance_status'];
    attendance = json['attendance'] != null
        ? AttendanceInfo.fromJson(json['attendance'])
        : null;
  }

}

class AttendanceInfo {
  int? id;
  int? userId;
  dynamic attendanceTime;
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
        this.attendanceOverTime,
        this.attendanceLateTime,
        this.attendanceStatus,
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

class Employee {
  int? id;
  String? email;
  String? code;
  String? fullName;
  String? fullNameEn;

  Employee({this.id, this.email, this.code, });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    code = json['code'];
    fullName = json['full_name'];
    fullNameEn = json['full_name_en'];
  }


}

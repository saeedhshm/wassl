import 'package:wassl/helpers/extensions/strings_extensions.dart';

import '../attendance.dart';



class MonthAttendance {
  TotalAttendances? totalAttendances;
  int? _countWorkDaysAbsent;
  int? _countWorkDaysAttend;
  int? countWorkDaysAttend;
  int? earlyLeaveDaysCount;
  int? lateAttendDaysCount;
  int? missingLeaveDaysCount;
  List<AttendancesOfMonth> attendancesOfMonth = [];
  List<TodayAttendance> todayAttendance = [];
  Schedule? schedule;

  MonthAttendance();


  MonthAttendance.fromJson(Map<String, dynamic> json) {
    totalAttendances = json['totalAttendances'] != null
        ?  TotalAttendances.fromJson(json['totalAttendances'])
        : null;
    _countWorkDaysAbsent = json['countWorkDaysAbsent'];
    _countWorkDaysAttend = json['countWorkDaysAttend'];
    earlyLeaveDaysCount = json['earlyLeaveDaysCount'];
    lateAttendDaysCount = json['lateAttendDaysCount'];
    missingLeaveDaysCount = json['missingLeaveDaysCount'];
    if (json['attendancesOfMonth'] != null) {
      attendancesOfMonth = <AttendancesOfMonth>[];
      json['attendancesOfMonth'].forEach((v) {
        attendancesOfMonth.add( AttendancesOfMonth.fromJson(v));
      });
    }
    if (json['todayAttendance'] != null) {
      todayAttendance = <TodayAttendance>[];
      json['todayAttendance'].forEach((v) {
        todayAttendance.add( TodayAttendance.fromJson(v));
      });
    }
    schedule = json['schedule'] != null
        ?  Schedule.fromJson(json['schedule'])
        : null;
  }




  int get missedRecords {
    return missingLeaveDaysCount ?? 0;
  }

  int get countWorkDaysAbsent{
    return _countWorkDaysAbsent ?? 0;
  }

  int get earlyLeaveCount{

    return earlyLeaveDaysCount ?? 0;
  }

  int get lateAttendance{
    return lateAttendDaysCount ?? 0;
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
    data['total'] = total;
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


  Holiday? holiday;
  Vacation? vacation;
  String? day;
  // List<Attendance> _attendance = <Attendance>[];
  List<Schedules> schedules = <Schedules>[];
  String? _status;

  // var selected = false;



  AttendancesOfMonth();
  AttendancesOfMonth.fromJson(Map<String, dynamic> json) {
    holiday =
    json['holiday'] != null ?  Holiday.fromJson(json['holiday']) : null;
    vacation = json['vacation'] != null
        ?  Vacation.fromJson(json['vacation'])
        : null;
    day = json['day'];
    // if (json['attendance'] != null) {
    //   _attendance = <Attendance>[];
    //   json['attendance'].forEach((v) {
    //     _attendance.add( Attendance.fromJson(v));
    //   });
    // }
    _status = json['status'];
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        Schedules schedule = Schedules.fromJson(v);
        if(_status == 'weekEnd'){
          schedule.attendanceStatus = 5;
        }
        if(_status == 'holiday'){
          schedule.attendanceStatus = 0;
        }
        if(_status == 'exempt'){
          schedule.attendanceStatus = 4;
        }
        schedules.add(schedule);
      });
    }

  }


  String get status{
    var st = _status ?? '';
    // if(st == 'attend'){
    //   for(var att in _attendance) {
    //     if(att.leaveTime.contains('----')){
    //       att.status = 'missed_leave';
    //   }
    //   }
    // }

    return st;
  }

  // List<Attendance> get attendance{
  //   _attendance.sort((a, b){
  //     if(a.empTimeIn != null && b.empTimeIn != null){
  //       return a.empTimeIn!.compareTo(b.empTimeIn!);
  //     }
  //     return -1;
  //   });
  //
  //   return _attendance;
  // }


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









class Holiday {
  int? id;
  String? occasion;
  String? dateFrom;
  String? dateTo;
  String? createdAt;
  String? updatedAt;
  int? companyId;
  String? branchId;

  Holiday(
      {this.id,
        this.occasion,
        this.dateFrom,
        this.dateTo,
        this.createdAt,
        this.updatedAt,
        this.companyId,
        this.branchId});

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    occasion = json['occasion'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyId = json['company_id'];
    branchId = json['branch_id'];
  }

}

class Vacation {
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? type;
  String? holidayStart;
  String? holidayEnd;
  dynamic ticket;
  dynamic ticketType;
  dynamic goDate;
  dynamic returnDate;
  dynamic exitAndReturnVisa;
  dynamic visaType;
  dynamic visaTime;
  dynamic visaRequireBefore;
  String? reason;
  int? status;
  dynamic file;
  String? createdAt;
  String? updatedAt;
  dynamic hrComment;
  dynamic activeResponsibleId;
  String? typeOfOrder;
  OrderType? orderType;

  Vacation(
      {this.id,
        this.employeeId,
        this.displayOrdersTo,
        this.type,
        this.holidayStart,
        this.holidayEnd,
        this.ticket,
        this.ticketType,
        this.goDate,
        this.returnDate,
        this.exitAndReturnVisa,
        this.visaType,
        this.visaTime,
        this.visaRequireBefore,
        this.reason,
        this.status,
        this.file,
        this.createdAt,
        this.updatedAt,
        this.hrComment,
        this.activeResponsibleId,
        this.typeOfOrder,
        this.orderType});

  Vacation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    type = json['type'];
    holidayStart = json['holiday_start'];
    holidayEnd = json['holiday_end'];
    ticket = json['ticket'];
    ticketType = json['ticket_type'];
    goDate = json['go_date'];
    returnDate = json['return_date'];
    exitAndReturnVisa = json['exit_and_return_visa'];
    visaType = json['visa_type'];
    visaTime = json['visa_time'];
    visaRequireBefore = json['visa_require_before'];
    reason = json['reason'];
    status = json['status'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hrComment = json['hr_comment'];
    activeResponsibleId = json['active_responsible_id'];
    typeOfOrder = json['type_of_order'];
    orderType = json['order_type'] != null
        ?  OrderType.fromJson(json['order_type'])
        : null;
  }

}

class OrderType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  OrderType({this.id, this.name, this.createdAt, this.updatedAt});

  OrderType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}



class Schedules {
  String? message;
  int? attendanceStatus;
  Attendance? attendance;
  dynamic vacation;
  Schedule? schedule;

  Schedules(
      {this.message,
        this.attendanceStatus,
        this.attendance,
        this.vacation,
        this.schedule});

  Schedules.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    attendanceStatus = json['attendance_status'];
    attendance = json['attendance'] != null
        ?  Attendance.fromJson(json['attendance'])
        : null;
    vacation = json['vacation'];
    schedule = json['schedule'] != null
        ?  Schedule.fromJson(json['schedule'])
        : null;
  }

  String get status {
    switch(attendanceStatus){
      case 0:
        return 'holiday';
      case 1:
        return 'absent';
      case 2:
        return 'missed_leave';
      case 3:
        return 'attend';
      case 4:
        return 'exempt';
      default:
        return 'weekEnd';
    }
    return attendanceStatus == 0 ? 'holiday' : attendanceStatus == 1 ? 'absent' : attendanceStatus == 2 ? 'missed_leave' : 'attend';
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


  String get timeInEx{
    // var time = '----';
    // if(_timeIn != null){
    //   time =  _timeIn?.split(' ')[1] ?? '----';
    // }
    return timeIn?.formattedTime() ?? '---';
  }
  String get timeOutEx{
    // var time = '----';
    // if(_timeOut != null){
    //   time =  _timeOut?.split(' ')[1] ?? '----';
    // }
    return timeOut?.formattedTime() ?? '---';
  }

}



class Schedule {
  int? id;
  int? companyId;
  int? type;
  String? slug;
  String? weekEndDays;
  String? timeIn;
  String? timeOut;
  Pivot? pivot;
  int? employeeId;
  int? scheduleId;
  int? minuteTimeOut;
  int? minuteTimeIn;
  dynamic allowTimeOut;
  dynamic allowTimeIn;
  Info? info;



  Schedule();

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    type = json['type'];
    slug = json['slug'];
    weekEndDays = json['week_end_days'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
    pivot = json['pivot'] != null ?  Pivot.fromJson(json['pivot']) : null;
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    minuteTimeOut = json['minute_time_out'];
    minuteTimeIn = json['minute_time_in'];
    allowTimeOut = json['allow_time_out'];
    allowTimeIn = json['allow_time_in'];
    info = json['info'] != null ?  Info.fromJson(json['info']) : null;
  }

}

class Pivot {
  int? employeeId;
  int? scheduleId;

  Pivot({this.employeeId, this.scheduleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
  }

}


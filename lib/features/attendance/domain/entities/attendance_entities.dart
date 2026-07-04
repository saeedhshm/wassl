class AttendanceEntity {
  final int? id;
  final int? userId;
  final String? attendanceTime;
  final String? leaveTime;
  final int? attendanceStatus;
  final String? attendanceLateTime;
  final String? attendanceOverTime;
  final String? leaveEarlyTime;
  final String? leaveOverTime;
  final int? scheduleId;
  final String? createdAt;

  const AttendanceEntity({
    this.id,
    this.userId,
    this.attendanceTime,
    this.leaveTime,
    this.attendanceStatus,
    this.attendanceLateTime,
    this.attendanceOverTime,
    this.leaveEarlyTime,
    this.leaveOverTime,
    this.scheduleId,
    this.createdAt,
  });
}

class MonthAttendanceEntity {
  final TotalAttendancesEntity? totalAttendances;
  final int? countWorkDaysAbsent;
  final int? countWorkDaysAttend;
  final int? earlyLeaveDaysCount;
  final int? lateAttendDaysCount;
  final int? missingLeaveDaysCount;
  final List<DayAttendanceEntity>? attendancesOfMonth;
  final List<TodayAttendanceEntity>? todayAttendance;

  const MonthAttendanceEntity({
    this.totalAttendances,
    this.countWorkDaysAbsent,
    this.countWorkDaysAttend,
    this.earlyLeaveDaysCount,
    this.lateAttendDaysCount,
    this.missingLeaveDaysCount,
    this.attendancesOfMonth,
    this.todayAttendance,
  });
}

class TotalAttendancesEntity {
  final String? total;
  final String? totalAttendanceLateTime;
  final String? totalAttendanceOverTime;
  final String? totalLeaveEarlyTime;
  final int? countWorkDays;
  final int? countWorkHour;

  const TotalAttendancesEntity({
    this.total,
    this.totalAttendanceLateTime,
    this.totalAttendanceOverTime,
    this.totalLeaveEarlyTime,
    this.countWorkDays,
    this.countWorkHour,
  });
}

class DayAttendanceEntity {
  final String? day;
  final String? status;
  final List<ScheduleEntity>? schedules;

  const DayAttendanceEntity({this.day, this.status, this.schedules});
}

class ScheduleEntity {
  final String? message;
  final int? attendanceStatus;
  final AttendanceEntity? attendance;

  const ScheduleEntity({this.message, this.attendanceStatus, this.attendance});
}

class TodayAttendanceEntity {
  final String? message;
  final int? attendanceStatus;
  final AttendanceEntity? attendance;

  const TodayAttendanceEntity({this.message, this.attendanceStatus, this.attendance});
}

class TeamAttendanceEntity {
  final int? id;
  final int? employeeId;
  final String? employeeName;
  final String? employeeNameEn;
  final List<AttendanceEntity>? attendance;

  const TeamAttendanceEntity({
    this.id,
    this.employeeId,
    this.employeeName,
    this.employeeNameEn,
    this.attendance,
  });
}

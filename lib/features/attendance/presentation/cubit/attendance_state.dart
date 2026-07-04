part of 'attendance_cubit.dart';

sealed class _AttendanceState {
  const _AttendanceState();
}

class AttendanceInitial extends _AttendanceState {
  const AttendanceInitial();
}

class AttendanceLoading extends _AttendanceState {
  const AttendanceLoading();
}

class MonthAttendanceLoaded extends _AttendanceState {
  final MonthAttendanceEntity attendance;
  final MonthAttendanceEntity? selectedDay;

  const MonthAttendanceLoaded(this.attendance, {this.selectedDay});
}

class TeamAttendanceLoaded extends _AttendanceState {
  final List<TeamAttendanceEntity> teamAttendance;

  const TeamAttendanceLoaded(this.teamAttendance);
}

class AttendanceCheckResult extends _AttendanceState {
  final Map<String, dynamic> status;

  const AttendanceCheckResult(this.status);
}

class AttendanceError extends _AttendanceState {
  final Failure failure;

  const AttendanceError(this.failure);
}

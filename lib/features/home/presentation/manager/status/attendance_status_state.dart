import 'package:equatable/equatable.dart';

abstract class AttendanceStatusState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceStatusInitState extends AttendanceStatusState {}

class RegisterAttendanceStatusState extends AttendanceStatusState {}

class RegisterLeaveStatusState extends AttendanceStatusState {}

class ShiftDoneStatusState extends AttendanceStatusState {}

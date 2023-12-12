import 'package:equatable/equatable.dart';

abstract class AttendanceState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  // @override
  // // TODO: implement stringify
  // bool? get stringify => true;
}

class AttendanceInitState extends AttendanceState {}

class AttendanceFingerPrintExceptionState extends AttendanceState {}

class AttendanceHolidayState extends AttendanceState {}

class AttendanceLoadingState extends AttendanceState {}

class HomeLocationEnabledState extends AttendanceState {}

class HomeLocationDeniedState extends AttendanceState {}

class HomeLocationDeniedForeverState extends AttendanceState {}

class HomeLocationSystemDisabledState extends AttendanceState {}

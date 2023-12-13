import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  // @override
  // // TODO: implement stringify
  // bool? get stringify => true;
}

class LocationLoadingState extends LocationState {}

class LocationEnabledState extends LocationState {}

class LocationDeniedState extends LocationState {}

class LocationDeniedForeverState extends LocationState {}

class LocationSystemDisabledState extends LocationState {}

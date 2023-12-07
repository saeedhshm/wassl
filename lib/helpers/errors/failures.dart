import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationFailure extends Failure {
  final String message;

  LocationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class DataFailure extends Failure {
  final String message;

  DataFailure(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'vacations_cubit.dart';

sealed class _VacationsState {
  const _VacationsState();
}

class VacationsInitial extends _VacationsState {
  const VacationsInitial();
}

class VacationsLoading extends _VacationsState {
  const VacationsLoading();
}

class VacationsLoaded extends _VacationsState {
  final VacationsEntity vacations;

  const VacationsLoaded(this.vacations);
}

class VacationsError extends _VacationsState {
  final Failure failure;

  const VacationsError(this.failure);
}

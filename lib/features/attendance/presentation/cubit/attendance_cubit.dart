import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/features/attendance/domain/entities/attendance_entities.dart';
import 'package:wassl/features/attendance/domain/repositories/attendance_repository.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<_AttendanceState> {
  final AttendanceRepository _repository;

  AttendanceCubit({required AttendanceRepository repository})
      : _repository = repository,
        super(const AttendanceInitial());

  Future<void> loadMonthAttendance({int? month, int? year}) async {
    emit(const AttendanceLoading());
    final result = await _repository.getMonthAttendance(month: month, year: year);
    if (result.failure != null) {
      emit(AttendanceError(result.failure!));
    } else {
      emit(MonthAttendanceLoaded(result.data!));
    }
  }

  Future<void> loadTeamAttendance() async {
    emit(const AttendanceLoading());
    final result = await _repository.getTeamAttendance();
    if (result.failure != null) {
      emit(AttendanceError(result.failure!));
    } else {
      emit(TeamAttendanceLoaded(result.data!));
    }
  }

  Future<void> checkIn() async {
    emit(const AttendanceLoading());
    final result = await _repository.checkIn();
    if (result.failure != null) {
      emit(AttendanceError(result.failure!));
    } else {
      emit(const AttendanceCheckResult({'status': 'checked_in'}));
    }
  }

  Future<void> checkOut() async {
    emit(const AttendanceLoading());
    final result = await _repository.checkOut();
    if (result.failure != null) {
      emit(AttendanceError(result.failure!));
    } else {
      emit(const AttendanceCheckResult({'status': 'checked_out'}));
    }
  }

  Future<void> checkStatus() async {
    emit(const AttendanceLoading());
    final result = await _repository.checkStatus();
    if (result.failure != null) {
      emit(AttendanceError(result.failure!));
    } else {
      emit(AttendanceCheckResult(result.data!));
    }
  }

  void resetState() => emit(const AttendanceInitial());
}

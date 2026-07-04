import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/features/vacations/domain/repositories/vacations_repository.dart';

part 'vacations_state.dart';

class VacationsCubit extends Cubit<_VacationsState> {
  final VacationsRepository _repository;

  VacationsCubit({required VacationsRepository repository})
      : _repository = repository,
        super(const VacationsInitial());

  Future<void> loadVacations() async {
    emit(const VacationsLoading());
    final result = await _repository.getVacations();
    if (result.failure != null) {
      emit(VacationsError(result.failure!));
    } else {
      emit(VacationsLoaded(result.data!));
    }
  }

  void resetState() => emit(const VacationsInitial());
}

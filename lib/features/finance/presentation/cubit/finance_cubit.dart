import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/features/finance/domain/entities/finance_entities.dart';
import 'package:wassl/features/finance/domain/repositories/finance_repository.dart';

part 'finance_state.dart';

class FinanceCubit extends Cubit<_FinanceState> {
  final FinanceRepository _repository;

  FinanceCubit({required FinanceRepository repository})
      : _repository = repository,
        super(const FinanceInitial());

  Future<void> loadSalaryDetails({String? month, String? year}) async {
    emit(const FinanceLoading());
    final result = await _repository.getSalaryDetails(month: month, year: year);
    if (result.failure != null) {
      emit(FinanceError(result.failure!));
    } else {
      emit(FinanceLoaded(result.data!));
    }
  }

  void resetState() => emit(const FinanceInitial());
}

part of 'finance_cubit.dart';

sealed class _FinanceState {
  const _FinanceState();
}

class FinanceInitial extends _FinanceState {
  const FinanceInitial();
}

class FinanceLoading extends _FinanceState {
  const FinanceLoading();
}

class FinanceLoaded extends _FinanceState {
  final FinanceEntity finance;

  const FinanceLoaded(this.finance);
}

class FinanceError extends _FinanceState {
  final Failure failure;

  const FinanceError(this.failure);
}

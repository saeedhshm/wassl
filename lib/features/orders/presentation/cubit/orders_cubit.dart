import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/features/orders/domain/entities/order_entities.dart';
import 'package:wassl/features/orders/domain/repositories/orders_repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository _repository;
  int _myOrdersPage = 1;
  int _teamOrdersPage = 1;

  OrdersCubit({required OrdersRepository repository})
      : _repository = repository,
        super(const OrdersInitial());

  Future<void> loadMyOrders({String? status}) async {
    emit(const OrdersLoading());
    final result = await _repository.getMyOrders(page: _myOrdersPage, status: status);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      final loadedState = state;
      final existingOrders = loadedState is OrdersLoaded ? loadedState.myOrders : <OrderEntity>[];
      emit(OrdersLoaded(
        myOrders: [...existingOrders, ...result.data!],
        teamOrders: loadedState is OrdersLoaded ? loadedState.teamOrders : [],
        currentPage: _myOrdersPage,
        hasMore: result.data!.isNotEmpty,
      ));
    }
  }

  Future<void> loadTeamOrders({String? status}) async {
    emit(const OrdersLoading());
    final result = await _repository.getTeamOrders(page: _teamOrdersPage, status: status);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      final loadedState = state;
      final existingOrders = loadedState is OrdersLoaded ? loadedState.teamOrders : <OrderEntity>[];
      emit(OrdersLoaded(
        teamOrders: [...existingOrders, ...result.data!],
        myOrders: loadedState is OrdersLoaded ? loadedState.myOrders : [],
        currentPage: _teamOrdersPage,
        hasMore: result.data!.isNotEmpty,
        isTeamOrders: true,
      ));
    }
  }

  Future<void> approveOrder(int orderId, String orderType, {String? comment}) async {
    emit(const OrdersLoading());
    final result = await _repository.setTeamOrderStatus(
      orderId: orderId,
      orderType: orderType,
      status: 2,
      comment: comment,
    );
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Order approved'));
      loadTeamOrders();
    }
  }

  Future<void> rejectOrder(int orderId, String orderType, {String? comment}) async {
    emit(const OrdersLoading());
    final result = await _repository.setTeamOrderStatus(
      orderId: orderId,
      orderType: orderType,
      status: 3,
      comment: comment,
    );
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Order rejected'));
      loadTeamOrders();
    }
  }

  Future<void> createHoliday(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createHoliday(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Holiday request created'));
    }
  }

  Future<void> cancelHoliday(int id) async {
    emit(const OrdersLoading());
    final result = await _repository.cancelHoliday(id);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Holiday cancelled'));
    }
  }

  Future<void> createLoan(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createLoan(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Loan request created'));
    }
  }

  Future<void> cancelLoan(int id) async {
    emit(const OrdersLoading());
    final result = await _repository.cancelLoan(id);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Loan cancelled'));
    }
  }

  Future<void> createPermission(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createPermission(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Permission request created'));
    }
  }

  Future<void> createLetter(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createLetter(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Letter request created'));
    }
  }

  Future<void> createVisa(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createVisa(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Visa request created'));
    }
  }

  Future<void> createCustody(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createCustody(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Custody request created'));
    }
  }

  Future<void> createFinancialExpense(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createFinancialExpense(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Financial expense created'));
    }
  }

  Future<void> createOvertime(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createOvertime(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Overtime request created'));
    }
  }

  Future<void> createFingerprintCorrection(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createFingerprintCorrection(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Fingerprint correction created'));
    }
  }

  Future<void> createApology(Map<String, dynamic> data, {String? filePath}) async {
    emit(const OrdersLoading());
    final result = await _repository.createApology(data, filePath: filePath);
    if (result.failure != null) {
      emit(OrdersError(result.failure!));
    } else {
      emit(const OrderActionSuccess('Apology request created'));
    }
  }

  void resetState() => emit(const OrdersInitial());
}

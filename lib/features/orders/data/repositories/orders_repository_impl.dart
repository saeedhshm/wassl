import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/core/error/result.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/orders/data/datasource/orders_data_sources.dart';
import 'package:wassl/features/orders/domain/entities/order_entities.dart';
import 'package:wassl/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<OrderEntity>>> getMyOrders({int page = 1, String? status}) async {
    try {
      final orders = await _remoteDataSource.getMyOrders(page: page, status: status);
      return success(orders);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<List<OrderEntity>>> getTeamOrders({int page = 1, String? status}) async {
    try {
      final orders = await _remoteDataSource.getTeamOrders(page: page, status: status);
      return success(orders);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<void>> setTeamOrderStatus({
    required int orderId,
    required String orderType,
    required int status,
    String? comment,
  }) async {
    try {
      await _remoteDataSource.setTeamOrderStatus(orderId, orderType, status, comment);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  @override
  Future<Result<void>> createHoliday(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addHolidayRequest, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateHoliday(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateHolidayRequest, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelHoliday(int id) => _cancelOrder(ApiEndpoints.cancelHolidayRequest, id);

  @override
  Future<Result<void>> createLoan(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addLoan, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateLoan(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateLoan, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelLoan(int id) => _cancelOrder(ApiEndpoints.cancelLoan, id);

  @override
  Future<Result<void>> createPermission(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addPermission, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updatePermission(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updatePermission, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelPermission(int id) => _cancelOrder(ApiEndpoints.cancelPermission, id);

  @override
  Future<Result<void>> createLetter(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addLetter, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateLetter(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateLetter, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelLetter(int id) => _cancelOrder(ApiEndpoints.cancelLetter, id);

  @override
  Future<Result<void>> createVisa(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addVisa, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateVisa(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateVisa, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelVisa(int id) => _cancelOrder(ApiEndpoints.cancelVisa, id);

  @override
  Future<Result<void>> createCustody(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addCustody, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateCustody(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateCustody, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelCustody(int id) => _cancelOrder(ApiEndpoints.cancelCustody, id);

  @override
  Future<Result<void>> createFinancialExpense(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addFinancialExpenses, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateFinancialExpense(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateFinancialExpenses, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelFinancialExpense(int id) =>
      _cancelOrder(ApiEndpoints.cancelFinancialExpenses, id);

  @override
  Future<Result<void>> createOvertime(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addOvertime, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateOvertime(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateOvertime, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelOvertime(int id) => _cancelOrder(ApiEndpoints.cancelOvertime, id);

  @override
  Future<Result<void>> createFingerprintCorrection(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addFingerPrintCorrection, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateFingerprintCorrection(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateFingerPrintCorrection, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelFingerprintCorrection(int id) =>
      _cancelOrder(ApiEndpoints.cancelFingerPrintCorrection, id);

  @override
  Future<Result<void>> createApology(Map<String, dynamic> data, {String? filePath}) async {
    return _createOrder(ApiEndpoints.addTabreer, data, filePath: filePath);
  }

  @override
  Future<Result<void>> updateApology(int id, Map<String, dynamic> data, {String? filePath}) async {
    return _updateOrder(ApiEndpoints.updateTabreer, id, data, filePath: filePath);
  }

  @override
  Future<Result<void>> cancelApology(int id) => _cancelOrder(ApiEndpoints.cancelTabreer, id);

  @override
  Future<Result<List<OrderTypeEntity>>> getOrderTypes(String typeUrl) async {
    try {
      final types = await _remoteDataSource.getOrderTypes(typeUrl);
      return success(types);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  Future<Result<void>> _createOrder(String url, Map<String, dynamic> data, {String? filePath}) async {
    try {
      await _remoteDataSource.createOrder(url, data, filePath: filePath);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  Future<Result<void>> _updateOrder(String url, int id, Map<String, dynamic> data, {String? filePath}) async {
    try {
      await _remoteDataSource.updateOrder(url, id, data, filePath: filePath);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  Future<Result<void>> _cancelOrder(String url, int id) async {
    try {
      await _remoteDataSource.cancelOrder(url, id);
      return success(null);
    } on Exception catch (e) {
      return failure(_mapException(e));
    }
  }

  Failure _mapException(Exception e) {
    if (e is ServerException) return ServerFailure(e.message);
    if (e is NetworkException) return const NetworkFailure();
    return UnexpectedFailure(e.toString());
  }
}

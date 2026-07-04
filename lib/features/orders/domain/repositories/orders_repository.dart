import 'package:wassl/core/error/result.dart';
import 'package:wassl/features/orders/domain/entities/order_entities.dart';

abstract class OrdersRepository {
  // My orders
  Future<Result<List<OrderEntity>>> getMyOrders({int page = 1, String? status});
  Future<Result<List<OrderEntity>>> getTeamOrders({int page = 1, String? status});
  Future<Result<void>> setTeamOrderStatus({
    required int orderId,
    required String orderType,
    required int status,
    String? comment,
  });

  // Holiday orders
  Future<Result<void>> createHoliday(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateHoliday(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelHoliday(int id);

  // Loan orders
  Future<Result<void>> createLoan(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateLoan(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelLoan(int id);

  // Permission orders
  Future<Result<void>> createPermission(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updatePermission(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelPermission(int id);

  // Letter orders
  Future<Result<void>> createLetter(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateLetter(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelLetter(int id);

  // Visa orders
  Future<Result<void>> createVisa(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateVisa(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelVisa(int id);

  // Custody orders
  Future<Result<void>> createCustody(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateCustody(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelCustody(int id);

  // Financial expenses
  Future<Result<void>> createFinancialExpense(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateFinancialExpense(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelFinancialExpense(int id);

  // Overtime
  Future<Result<void>> createOvertime(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateOvertime(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelOvertime(int id);

  // Fingerprint correction
  Future<Result<void>> createFingerprintCorrection(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateFingerprintCorrection(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelFingerprintCorrection(int id);

  // Apology/Tabreer
  Future<Result<void>> createApology(Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> updateApology(int id, Map<String, dynamic> data, {String? filePath});
  Future<Result<void>> cancelApology(int id);

  // Order types
  Future<Result<List<OrderTypeEntity>>> getOrderTypes(String typeUrl);
}

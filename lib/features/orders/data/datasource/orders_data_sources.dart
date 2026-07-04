import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/orders/domain/entities/order_entities.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderEntity>> getMyOrders({int page = 1, String? status});
  Future<List<OrderEntity>> getTeamOrders({int page = 1, String? status});
  Future<void> setTeamOrderStatus(int orderId, String orderType, int status, String? comment);
  Future<void> createOrder(String url, Map<String, dynamic> data, {String? filePath});
  Future<void> updateOrder(String url, int id, Map<String, dynamic> data, {String? filePath});
  Future<void> cancelOrder(String url, int id);
  Future<List<OrderTypeEntity>> getOrderTypes(String url);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<OrderEntity>> getMyOrders({int page = 1, String? status}) async {
    final response = await _apiClient.get(ApiEndpoints.getAllOrders, queryParameters: {
      'page': page,
      if (status != null) 'status': status,
    });
    return _parseOrders(response.data);
  }

  @override
  Future<List<OrderEntity>> getTeamOrders({int page = 1, String? status}) async {
    final response = await _apiClient.get(ApiEndpoints.getTeamOrders, queryParameters: {
      'page': page,
      if (status != null) 'status': status,
    });
    return _parseOrders(response.data);
  }

  @override
  Future<void> setTeamOrderStatus(int orderId, String orderType, int status, String? comment) async {
    await _apiClient.post('${ApiEndpoints.getTeamOrders}/$orderId/status', data: {
      'order_type': orderType,
      'status': status,
      if (comment != null) 'comment': comment,
    });
  }

  @override
  Future<void> createOrder(String url, Map<String, dynamic> data, {String? filePath}) async {
    if (filePath != null) {
      await _apiClient.uploadFile(url, filePath: filePath, fields: data);
    } else {
      await _apiClient.post(url, data: data);
    }
  }

  @override
  Future<void> updateOrder(String url, int id, Map<String, dynamic> data, {String? filePath}) async {
    await _apiClient.put('$url/$id', data: data);
  }

  @override
  Future<void> cancelOrder(String url, int id) async {
    await _apiClient.post('$url/$id/cancel');
  }

  @override
  Future<List<OrderTypeEntity>> getOrderTypes(String url) async {
    final response = await _apiClient.get(url);
    return _parseOrderTypes(response.data);
  }

  List<OrderEntity> _parseOrders(dynamic responseData) {
    if (responseData is List) {
      return responseData.map((e) => OrderEntity(
        id: e['id'] as int? ?? 0,
        employeeId: e['employee_id'] as int?,
        type: e['type']?.toString(),
        createdAt: e['created_at']?.toString(),
        updatedAt: e['updated_at']?.toString(),
        statusId: e['status_id'] as int?,
        orderName: e['order_name']?.toString(),
        orderDate: e['order_date']?.toString(),
        orderStatus: e['order_status']?.toString(),
        pdfUrl: e['pdf_url']?.toString(),
      )).toList();
    }
    return [];
  }

  List<OrderTypeEntity> _parseOrderTypes(dynamic responseData) {
    if (responseData is List) {
      return responseData.map((e) => OrderTypeEntity(
        id: e['id'] as int? ?? 0,
        name: e['name']?.toString() ?? '',
      )).toList();
    }
    return [];
  }
}

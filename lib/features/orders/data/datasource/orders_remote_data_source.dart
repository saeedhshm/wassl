import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/orders/data/datasource/orders_data_sources.dart';
import 'package:wassl/features/orders/domain/entities/order_entities.dart';

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<OrderEntity>> getMyOrders({int page = 1, String? status}) async {
    var url = '${ApiEndpoints.getAllOrders}?page=$page';
    if (status != null && status.isNotEmpty) url += '&status=$status';
    final response = await _apiClient.get(url);
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      return _parseOrdersList(data);
    }
    throw ServerException(statusCode: response.statusCode);
  }

  @override
  Future<List<OrderEntity>> getTeamOrders({int page = 1, String? status}) async {
    var url = '${ApiEndpoints.getTeamOrders}?page=$page';
    if (status != null && status.isNotEmpty) url += '&status=$status';
    final response = await _apiClient.get(url);
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      return _parseOrdersList(data);
    }
    throw ServerException(statusCode: response.statusCode);
  }

  @override
  Future<void> setTeamOrderStatus(int orderId, String orderType, int status, String? comment) async {
    await _apiClient.post(
      ApiEndpoints.setTeamOrderStatus,
      data: {
        'order_id': orderId.toString(),
        'order_type': orderType,
        'status': status.toString(),
        if (comment != null) 'hr_comment': comment,
      },
    );
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
    final fullUrl = '$url/$id';
    if (filePath != null) {
      await _apiClient.uploadFile(fullUrl, filePath: filePath, fields: data);
    } else {
      await _apiClient.post(fullUrl, data: data);
    }
  }

  @override
  Future<void> cancelOrder(String url, int id) async {
    await _apiClient.put('$url/$id');
  }

  @override
  Future<List<OrderTypeEntity>> getOrderTypes(String url) async {
    final response = await _apiClient.get(url);
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final list = data['data'] as List<dynamic>? ?? [];
      return list.map((e) => OrderTypeEntity(
        id: e['id'] as int,
        name: e['name']?.toString() ?? e['_name_ar']?.toString() ?? '',
      )).toList();
    }
    throw ServerException(statusCode: response.statusCode);
  }

  List<OrderEntity> _parseOrdersList(Map<String, dynamic> json) {
    final ordersJson = json['orders'] as List<dynamic>? ?? json['data'] as List<dynamic>? ?? [];
    return ordersJson.map((e) => _parseOrder(e as Map<String, dynamic>)).toList();
  }

  OrderEntity _parseOrder(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int?,
      displayOrdersTo: json['display_orders_to'] as int?,
      type: json['type_of_order']?.toString(),
      reason: json['reason']?.toString(),
      file: json['file']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      statusId: json['status'] as int?,
      orderName: json['order_name']?.toString(),
      orderDate: json['order_date']?.toString(),
      orderStatus: json['order_status']?.toString(),
      pdfUrl: json['pdf_url']?.toString(),
      activeResponsibleId: json['active_responsible_id'] as int?,
      status: json['status_obj'] != null
          ? OrderStatusEntity(
              id: json['status_obj']['id'] as int,
              statusAr: json['status_obj']['_status_ar']?.toString() ?? '',
              statusEn: json['status_obj']['_status_en']?.toString() ?? '',
            )
          : null,
      responsibleEmployee: json['name_employee'] != null
          ? ResponsibleEmployeeEntity(
              id: json['name_employee']['id'] as int?,
              fullName: json['name_employee']['_full_name']?.toString(),
              fullNameEn: json['name_employee']['_full_name_en']?.toString(),
            )
          : null,
      orderType: json['type'] != null
          ? OrderTypeEntity(
              id: json['type']['id'] as int,
              name: json['type']['name']?.toString() ?? json['type']['_name_ar']?.toString() ?? '',
            )
          : null,
      confirmations: (json['confirmation'] as List<dynamic>?)
          ?.map((c) => ConfirmationEntity(
                id: c['id'] as int?,
                employeeId: c['employee_id'] as int?,
                orderId: c['order_id'] as int?,
                status: c['status'] as int?,
                hrComment: c['hr_comment']?.toString(),
                responsibleEmployee: c['responsible_employee'] != null
                    ? ResponsibleEmployeeEntity(
                        id: c['responsible_employee']['id'] as int?,
                        fullName: c['responsible_employee']['_full_name']?.toString(),
                        fullNameEn: c['responsible_employee']['_full_name_en']?.toString(),
                      )
                    : null,
              ))
          .toList(),
      hrComment: json['hr_comment']?.toString(),
    );
  }
}

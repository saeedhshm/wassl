import 'package:wassl/features/orders/data/datasource/orders_data_sources.dart';
import 'package:wassl/features/orders/domain/entities/order_entities.dart';

class MockOrdersRemoteDataSource implements OrdersRemoteDataSource {
  @override
  Future<List<OrderEntity>> getMyOrders({int page = 1, String? status}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockOrders;
  }

  @override
  Future<List<OrderEntity>> getTeamOrders({int page = 1, String? status}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockOrders;
  }

  @override
  Future<void> setTeamOrderStatus(int orderId, String orderType, int status, String? comment) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> createOrder(String url, Map<String, dynamic> data, {String? filePath}) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<void> updateOrder(String url, int id, Map<String, dynamic> data, {String? filePath}) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<void> cancelOrder(String url, int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<List<OrderTypeEntity>> getOrderTypes(String url) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      OrderTypeEntity(id: 1, name: 'Type 1'),
      OrderTypeEntity(id: 2, name: 'Type 2'),
      OrderTypeEntity(id: 3, name: 'Type 3'),
    ];
  }

  List<OrderEntity> get _mockOrders => [];
}

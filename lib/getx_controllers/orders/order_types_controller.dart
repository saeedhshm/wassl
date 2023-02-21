import '../../models/orders/order_type.dart';

class OrderTypesRetriever {
  bool? success;
  List<OrderType>? data;
  String? message;

  OrderTypesRetriever({this.success, this.data, this.message});

  OrderTypesRetriever.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OrderType>[];
      json['data'].forEach((v) {
        data!.add(OrderType.fromJson(v));
      });
    }
    message = json['message'];
  }
}
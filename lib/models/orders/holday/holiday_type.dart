import 'package:wassl/models/orders/order_type.dart';

class HolidayTypes {
  bool? success;
  List<OrderType>? data;
  String? message;

  HolidayTypes({this.success, this.data, this.message});

  HolidayTypes.fromJson(Map<String, dynamic> json) {
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



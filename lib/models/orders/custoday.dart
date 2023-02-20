
import 'package:get/get.dart';

import 'AllOrders.dart';
import 'order_type.dart';

class CustodyDate implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  OrderType? type;
  String? _reason;
  dynamic status;
  dynamic file;
  String? createdAt;
  String? updatedAt;

  CustodyDate();

  CustodyDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    type = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    _reason = json['reason'];
    status = json['status'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  @override
  // TODO: implement orderType
  String get orderType => 'CustodyDate';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (createdAt ?? '').split('T')[0];
  }

  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '$status';

  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');
}
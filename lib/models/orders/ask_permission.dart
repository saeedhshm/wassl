import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';

class AskPermissionsData implements Order {
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  @override
  OrderType? type;
  String? date;
  OrderType? reasonType;
  String? _reason;
  @override
  Status? status;
  String? _file;
  String? createdAt;
  String? updatedAt;



  AskPermissionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    type = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    date = json['date'];
    reasonType = json['reason_type'] != null
        ? OrderType.fromJson(json['reason_type'])
        : null;
    _reason = json['reason'];
    status =
    json['status'] != null ?Status.fromJson(json['status']) : null;
    _file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderName => 'AskPermissionsData';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (date ?? '').split('T')[0];
  }

  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '${status?.statusAr}';

  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');

  @override
  // TODO: implement orderStatus
  int get statusID => status == null  ? 1 : status?.id ?? 1;

  @override
  // TODO: implement orderStatus
  int get orderID =>  id ?? -1;

}


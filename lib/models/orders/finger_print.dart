
import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';

class FingerprintCorrectionsData implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? date;
  @override
  OrderType? type;
  String? time;
  dynamic _reason;
  @override
  Status? status;
  dynamic _file;
  String? createdAt;
  String? updatedAt;

  FingerprintCorrectionsData();

  FingerprintCorrectionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    date = json['date'];
    time = json['time'];
    type = json['working_type'] != null ? OrderType.fromJson(json['working_type']) : null;
    _reason = json['reason'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }



  // String get workingType => '${_workingType?.name}';

  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderName => 'FingerprintCorrectionsData';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (date ?? '');
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

import 'AllOrders.dart';

class FingerprintCorrectionsData implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? date;
  String? workingType;
  dynamic _reason;
  dynamic status;
  dynamic file;
  String? createdAt;
  String? updatedAt;

  FingerprintCorrectionsData();

  FingerprintCorrectionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    date = json['date'];
    workingType = json['working_type'];
    _reason = json['reason'];
    status = json['status'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }



  @override
  // TODO: implement orderType
  String get orderType => 'FingerprintCorrectionsData';

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
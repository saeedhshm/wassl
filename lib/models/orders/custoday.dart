
import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';

class CustodyDate implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  @override
  OrderType? type;
  String? _reason;
  @override
  Status? status;
  dynamic _file;
  String? createdAt;
  String? updatedAt;
  @override
  int? activeResponsibleId;
  @override
  ResponsibleEmployee? nameEmployee;
  @override
  List<Confirmation>? confirmation;

  @override
  var hrComment;
  CustodyDate();

  CustodyDate.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    pdfUrl = json['pdf_url'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    type = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    _reason = json['reason'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hrComment = json['hr_comment'];
    nameEmployee = json['name'] != null
        ? ResponsibleEmployee.fromJson(json['name'])
        : null;
    activeResponsibleId = json['active_responsible_id'];
    if (json['confirmation'] != null) {
      confirmation = <Confirmation>[];
      json['confirmation'].forEach((v) {
        confirmation!.add(Confirmation.fromJson(v));
      });
    }
  }

  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderName => 'CustodyDate';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (createdAt ?? '').split('T')[0];
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

  @override
  String? pdfUrl;
}
import 'package:wassl/models/orders/order_type.dart';

import 'AllOrders.dart';
import 'order_status.dart';

class LoansData implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  @override
  OrderType? type;
  dynamic amount;
  String? month;
  String? monthlyInstallment;
  dynamic installmentAmount;
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
  LoansData();

  LoansData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    type = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    amount = json['amount'];
    month = json['month'];
    monthlyInstallment = json['monthly_installment'];
    installmentAmount = json['installment_amount'];
    _reason = json['reason'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hrComment = json['hr_comment'];
    activeResponsibleId = json['active_responsible_id'];
    nameEmployee = json['name'] != null
        ? ResponsibleEmployee.fromJson(json['name'])
        : null;
    if (json['confirmation'] != null) {
      confirmation = <Confirmation>[];
      json['confirmation'].forEach((v) {
        confirmation!.add(Confirmation.fromJson(v));
      });
    }
  }


  String get loanType => type?.name ?? '';

  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderName => 'LoansData';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (month ?? '');
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
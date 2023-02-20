import 'package:wassl/models/orders/order_type.dart';

import 'AllOrders.dart';

class LoansData implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  OrderType? type;
  int? amount;
  String? month;
  String? monthlyInstallment;
  int? installmentAmount;
  String? _reason;
  dynamic status;
  dynamic file;
  String? createdAt;
  String? updatedAt;

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
    status = json['status'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  String get loanType => type?.name ?? '';


  @override
  // TODO: implement orderType
  String get orderType => 'LoansData';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (month ?? '');
  }

  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '$status';


  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');
}
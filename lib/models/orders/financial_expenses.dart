
import 'AllOrders.dart';

class FinancialExpensesDate implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? name;
  int? amount;
  String? date;
  dynamic description;
  dynamic _reason;
  dynamic status;
  dynamic file;
  String? createdAt;
  String? updatedAt;

  FinancialExpensesDate();

  FinancialExpensesDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    name = json['name'];
    amount = json['amount'];
    date = json['date'];
    description = json['description'];
    _reason = json['reason'];
    status = json['status'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  @override
  // TODO: implement orderType
  String get orderType => 'FinancialExpensesDate';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (date ?? '');
  }
  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '$status';


  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');
}

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';

class FinancialExpensesDate implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  Name? _name;
  dynamic amount;
  String? date;
  dynamic description;
  dynamic _reason;
  @override
  Status? status;
  dynamic _file;
  String? createdAt;
  String? updatedAt;
  @override
  OrderType? type;
  @override
  int? activeResponsibleId;
  @override
  ResponsibleEmployee? nameEmployee;
  @override
  List<Confirmation>? confirmation;

  @override
  var hrComment;
  FinancialExpensesDate();

  FinancialExpensesDate.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    pdfUrl = json['pdf_url'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    if(json['name'] != null){
      if(json['name'] is Map<String, dynamic>){
        _name = json['name'] != null ?  Name.fromJson(json['name']) : null;
      }else{
        _name = json['name'] != null ?  Name.withString(json['name']) : null;
      }
    }

    amount = json['amount'];
    date = json['date'];
    description = json['description'];
    _reason = json['reason'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hrComment = json['hr_comment'];
    activeResponsibleId = json['active_responsible_id'];
    if(json['name'].toString().isEmpty){
      nameEmployee = json['name'] != null
          ? ResponsibleEmployee.fromJson(json['name'])
          : null;
    }
    if (json['confirmation'] != null) {
      confirmation = <Confirmation>[];
      json['confirmation'].forEach((v) {
        confirmation!.add(Confirmation.fromJson(v));
      });
    }
  }

  String get name{
    return ('lang_code'.tr == 'ar' ? _name?.fullName : _name?.fullNameEn) ?? '';
  }


  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderName => 'FinancialExpensesDate';

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

  @override
  String? pdfUrl;
}

class Name {
  int? id;
  String? fullName;
  String? fullNameEn;

  Name.withString(String name){
    fullNameEn = name;
    fullName = name;
  }

  Name({this.id, this.fullName, this.fullNameEn});

  Name.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    fullNameEn = json['full_name_en'];
  }


}
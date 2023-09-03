
import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/tabreer.dart';
import 'package:wassl/models/orders/visa_order.dart';

import '../../getx_controllers/app_controller.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../web_services_helper/api.dart';
import 'ask_permission.dart';
import 'custoday.dart';
import 'financial_expenses.dart';
import 'finger_print.dart';
import 'holiday.dart';
import 'letter.dart';
import 'loan_order.dart';
import 'order_status.dart';
import 'order_type.dart';
import 'over_time.dart';

class AllOrders {

  List<Order> orders = [];
  bool? success;
  String? message;

  AppController? appController;
  String? url;

  AllOrders(this.appController);

  AllOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    var orderType = 'type_of_order';

    if (json['orders'] != null) {

      json['orders'].forEach((v) {

        if(v[orderType] == 'permission'){
          orders.add( AskPermissionsData.fromJson(v));
        }else if(v[orderType] == 'holiday'){
          orders.add( HolidaysData.fromJson(v));
        }else if(v[orderType] == 'fingerprint'){
          orders.add( FingerprintCorrectionsData.fromJson(v));
        }else if(v[orderType] == 'loan'){
          orders.add( LoansData.fromJson(v));
        }else if(v[orderType] == 'letter'){
          orders.add( LetterDate.fromJson(v));
        }else if(v[orderType] == 'custody'){
          orders.add( CustodyDate.fromJson(v));
        }else if(v[orderType] == 'visa'){
          orders.add(OrderVisaData.fromJson(v));
        }else if(v[orderType] == 'overtime'){
          orders.add( OvertimeData.fromJson(v));
        }else if(v[orderType] == 'financial'){
          orders.add( FinancialExpensesDate.fromJson(v));
        }else if(v[orderType] == 'tabrir'){
          orders.add( ApologyData.fromJson(v));
        }
      });
    }


    message = json['message'];
  }

  Future<List<Order>> getAllOrders() async {



    var response = await AppApiHandler.getData(url: url!,header: appController!.appHeader);


    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    var json = jsonDecode(response.body);
    var value = AllOrders.fromJson(json);

    return value.orders;

  }

}
abstract class Order{
  String get orderName;
  String get orderDate;
  String get orderStatus;
  String get reason;
  String get file;
  int get statusID;
  int get orderID;
  String? pdfUrl;
  Status? status;
  ResponsibleEmployee? nameEmployee;
  // bool teamOrder = false;

  dynamic hrComment;
  int? activeResponsibleId;
  List<Confirmation>? confirmation;

  OrderType? type;
}


class Confirmation {
  int? id;
  int? employeeId;
  int? orderId;
  String? responsibleEmployeeId;
  int? sortOrder;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? orderType;
  ResponsibleEmployee? responsibleEmployee;

  Confirmation(
      {this.id,
        this.employeeId,
        this.orderId,
        this.responsibleEmployeeId,
        this.sortOrder,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.orderType,
        this.responsibleEmployee});

  Confirmation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    orderId = json['order_id'];
    responsibleEmployeeId = json['responsible_employee_id'];
    sortOrder = json['sort_order'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderType = json['order_type'];
    responsibleEmployee = json['responsible_employee'] != null
        ? new ResponsibleEmployee.fromJson(json['responsible_employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['order_id'] = this.orderId;
    data['responsible_employee_id'] = this.responsibleEmployeeId;
    data['sort_order'] = this.sortOrder;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_type'] = this.orderType;
    if (this.responsibleEmployee != null) {
      data['responsible_employee'] = this.responsibleEmployee!.toJson();
    }
    return data;
  }
}

class ResponsibleEmployee {
  int? id;
  String? _fullName;
  String? _fullNameEn;

  ResponsibleEmployee({this.id,});

  ResponsibleEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    _fullName = json['full_name'];
    _fullNameEn = json['full_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this._fullName;
    data['full_name_en'] = this._fullNameEn;
    return data;
  }

  String get fullName{
    return ('lang_code'.tr == 'ar' ? _fullName : _fullNameEn) ?? '';
  }
}









import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/models/orders/tabreer.dart';
import 'package:wassl/models/orders/visa_order.dart';

import '../../getx_controllers/app_controller.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../web_services_helper/api.dart';
import '../countries/city.dart';
import '../countries/country.dart';
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
  int? businessTripId;
  int? daysCount;
  int? costPerDay;
  int? totalCost;
  BusinessTrip? businessTrip;
  String? hrComment;
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

    businessTripId = json['business_trip_id'];
    daysCount = json['days_count'];
    costPerDay = json['cost_per_day'];
    totalCost = json['total_cost'];
    businessTrip = json['business_trip'] != null
        ? BusinessTrip.fromJson(json['business_trip'])
        : null;
    hrComment = json['hr_comment'];
    responsibleEmployee = json['responsible_employee'] != null
        ? ResponsibleEmployee.fromJson(json['responsible_employee'])
        : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = _fullName;
    data['full_name_en'] = _fullNameEn;
    return data;
  }

  String get fullName{
    return ('lang_code'.tr == 'ar' ? _fullName : _fullNameEn) ?? '';
  }
}

class BusinessTrip {
  int? id;
  int? companyId;
  int? countryId;
  int? regionId;
  int? costPerDay;
  String? createdAt;
  String? updatedAt;
  Country? country;
  City? region;

  BusinessTrip(
      {this.id,
        this.companyId,
        this.countryId,
        this.regionId,
        this.costPerDay,
        this.createdAt,
        this.updatedAt,
        this.country,
        this.region});

  BusinessTrip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    countryId = json['country_id'];
    regionId = json['region_id'];
    costPerDay = json['cost_per_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    country =
    json['country'] != null ? Country.fromJson(json['country']) : null;
    region =
    json['region'] != null ? City.fromJson(json['region']) : null;
  }

}








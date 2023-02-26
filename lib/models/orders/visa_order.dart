import 'package:get/get.dart';

import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';



class OrderVisaData  implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  OrderType? _type;
  OrderType? _visaTime;
  String? requiredBefore;
  String? ticket;
  OrderType? _ticketType;
  String? goDate;
  String? backDate;
  String? _reason;
  Status? status;
  String? _file;
  String? createdAt;
  String? updatedAt;



  OrderVisaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    _type = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    _visaTime =
    json['visa_time'] != null ? OrderType.fromJson(json['visa_time']) : null;
    requiredBefore = json['required_before'];
    ticket = json['ticket'];
    _ticketType = json['ticket_type'] != null
        ? OrderType.fromJson(json['ticket_type'])
        : null;
    goDate = json['go_date'];
    backDate = json['back_date'];
    _reason = json['reason'];
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    _file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String get visaType => _type?.name ?? '';
  String get ticketType => _ticketType?.name != null ? 'ticket_type'.tr + ': '+'${_ticketType?.name}' : 'without_ticket'.tr;
  String get visaTime => _visaTime?.name ?? '';

  bool get hasTicket => (ticket ?? '') == 'on';
  bool get hasBackTicket => (backDate ?? '') != '';

  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderType => 'OrderVisaData';
  @override
  // TODO: implement orderDate
  String get orderDate {
    return (requiredBefore ?? '').split('T')[0];
  }

  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '${status?.statusAr}';


  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');

}





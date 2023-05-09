import 'package:get/get.dart';

import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';



class OrderVisaData  implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;

  @override
  OrderType? type;
  OrderType? orderVisaTime;
  OrderType? orderVisaTicketType;

  String? requiredBefore;
  String? ticket;

  String? goDate;
  String? backDate;
  String? _reason;
  @override
  Status? status;
  String? _file;
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


  OrderVisaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    type = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    orderVisaTime =
    json['visa_time'] != null ? OrderType.fromJson(json['visa_time']) : null;
    requiredBefore = json['required_before'];
    ticket = json['ticket'];
    orderVisaTicketType = json['ticket_type'] != null
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
    hrComment = json['hr_comment'];
    activeResponsibleId = json['active_responsible_id'];
    if (json['confirmation'] != null) {
      confirmation = <Confirmation>[];
      json['confirmation'].forEach((v) {
        confirmation!.add(Confirmation.fromJson(v));
      });
    }
  }

  String get visaType => type?.name ?? '';
  String get ticketType => orderVisaTicketType?.name != null ? 'ticket_type'.tr + ': '+'${orderVisaTicketType?.name}' : 'without_ticket'.tr;
  String get visaTime => orderVisaTime?.name ?? '';

  bool get hasTicket => (ticket ?? '') == 'on';
  bool get hasBackTicket => (backDate ?? '') != '';

  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderName => 'OrderVisaData';
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

  @override
  // TODO: implement orderStatus
  int get statusID => status == null  ? 1 : status?.id ?? 1;

  @override
  // TODO: implement orderStatus
  int get orderID =>  id ?? -1;

}





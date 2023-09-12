import 'orders/order_type.dart';

class Vacation {
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? type;
  String? holidayStart;
  String? holidayEnd;
  Null? ticket;
  Null? ticketType;
  Null? goDate;
  Null? returnDate;
  Null? exitAndReturnVisa;
  Null? visaType;
  Null? visaTime;
  Null? visaRequireBefore;
  String? reason;
  int? status;
  Null? file;
  String? createdAt;
  String? updatedAt;
  Null? hrComment;
  Null? activeResponsibleId;
  String? typeOfOrder;
  OrderType? orderType;

  Vacation();

  Vacation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    type = json['type'];
    holidayStart = json['holiday_start'];
    holidayEnd = json['holiday_end'];
    ticket = json['ticket'];
    ticketType = json['ticket_type'];
    goDate = json['go_date'];
    returnDate = json['return_date'];
    exitAndReturnVisa = json['exit_and_return_visa'];
    visaType = json['visa_type'];
    visaTime = json['visa_time'];
    visaRequireBefore = json['visa_require_before'];
    reason = json['reason'];
    status = json['status'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hrComment = json['hr_comment'];
    activeResponsibleId = json['active_responsible_id'];
    typeOfOrder = json['type_of_order'];
    orderType = json['order_type'] != null
        ? new OrderType.fromJson(json['order_type'])
        : null;
  }

}
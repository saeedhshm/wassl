import 'orders/order_type.dart';

class Vacation {
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? type;
  String? holidayStart;
  String? holidayEnd;
  void ticket;
  void ticketType;
  void goDate;
  void returnDate;
  void exitAndReturnVisa;
  void visaType;
  void visaTime;
  void visaRequireBefore;
  String? reason;
  int? status;
  void file;
  String? createdAt;
  String? updatedAt;
  void hrComment;
  void activeResponsibleId;
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
        ? OrderType.fromJson(json['order_type'])
        : null;
  }

}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';

class HolidaysData implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  OrderType? _holidayType;
  String? holidayStart;
  String? holidayEnd;
  String? ticket;
  OrderType? ticketType;
  String? goDate;
  String? returnDate;
  String? exitAndReturnVisa;
  String? visaType;
  OrderType? visaTime;
  String? visaRequireBefore;
  String? _reason;
  dynamic status;
  dynamic file;
  String? createdAt;
  String? updatedAt;

 HolidaysData();

  HolidaysData.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];

    holidayStart = json['holiday_start'];
    // final validMap =
    // jsonDecode(jsonEncode(json['type'])) as Map<String, dynamic>;
    _holidayType = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    holidayEnd = json['holiday_end'];
    ticket = json['ticket'];
    ticketType = json['ticket_type'] != null ? OrderType.fromJson(json['ticket_type']) : null ;
    goDate = json['go_date'];
    returnDate = json['return_date'];
    exitAndReturnVisa = json['exit_and_return_visa'];
    visaType = json['visa_type'];
    visaTime = json['visa_time'] != null ? OrderType.fromJson(json['visa_time']) : null  ;
    visaRequireBefore = json['visa_require_before'];
    _reason = json['reason'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  String get differenceInDays{
    String difference = '';
    var startDayARR = (holidayStart ?? '').split('-');
    var endDayARR = (holidayEnd ?? '').split('-');

    final startDay = DateTime(int.parse(startDayARR[0]),int.parse(startDayARR[1]),int.parse(startDayARR[2]));
    final endDay = DateTime(int.parse(endDayARR[0]),int.parse(endDayARR[1]),int.parse(endDayARR[2]));

    println('=-==-=--=-=-=-= startDay =-===-=-');
    println(startDay);
    println(endDay);
    println('=-==-=--=-=-=-= startDay =-===-=-');

    final days = (endDay.difference(startDay).inDays + 1);
    difference = days == 1 ? 'day'.tr : days == 2 ? '2_days'.tr : (days.toString() + ' ' + 'days'.tr);
    return difference;
  }

  @override
  // TODO: implement orderType
  String get orderType => 'HolidaysData';

  String get holidayType => '${_holidayType?.name}';

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (createdAt ?? '').split('T')[0];
  }

  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '${status?.statusAr}';

  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');
}

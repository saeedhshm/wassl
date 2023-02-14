
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import 'AllOrders.dart';

class HolidaysData implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? type;
  String? holidayStart;
  String? holidayEnd;
  String? ticket;
  String? ticketType;
  String? goDate;
  String? returnDate;
  String? exitAndReturnVisa;
  String? visaType;
  String? visaTime;
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
    _reason = json['reason'];
    status = json['status'];
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

  @override
  // TODO: implement orderDate
  String get orderDate {
    return (createdAt ?? '').split('T')[0];
  }

  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '$status';

  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');
}

// @override
// // TODO: implement reason
// String get reason {
//   print('=-=-=-=-=-=-=-=-=-=- reason $_reason');
//   return (_reason == null || _reason == '') ? 'unspecified'.tr : (_reason ?? '');
// }
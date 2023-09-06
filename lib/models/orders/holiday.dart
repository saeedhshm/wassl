
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
  @override
  OrderType? type;
  String? holidayStart;
  String? holidayEnd;
  String? ticket;
  OrderType? _ticketType;
  String? goDate;
  String? returnDate;
  String? exitAndReturnVisa;
  OrderType? _visaType;
  OrderType? _visaTime;
  String? visaRequireBefore;
  String? _reason;
  @override
  Status? status;
  dynamic _file;
  String? createdAt;
  String? updatedAt;
  @override
  int? activeResponsibleId;
  @override
  ResponsibleEmployee? nameEmployee;
  @override
  List<Confirmation>? confirmation;
  @override
  dynamic hrComment;

 HolidaysData();

  HolidaysData.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    pdfUrl = json['pdf_url'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];

    holidayStart = json['holiday_start'];
    // final validMap =
    // jsonDecode(jsonEncode(json['type'])) as Map<String, dynamic>;

    type = json['type'] != null ? OrderType.fromJson(json['type']) : null;
    holidayEnd = json['holiday_end'];
    ticket = json['ticket'];
    _ticketType = json['ticket_type'] != null ? OrderType.fromJson(json['ticket_type']) : null ;
    goDate = json['go_date'];
    returnDate = json['return_date'];
    exitAndReturnVisa = json['exit_and_return_visa'];
    _visaType = json['visa_type'] != null ? OrderType.fromJson(json['visa_type']) : null  ;
    _visaTime = json['visa_time'] != null ? OrderType.fromJson(json['visa_time']) : null  ;
    visaRequireBefore = json['visa_require_before'];
    _reason = json['reason'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
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
    nameEmployee = json['name'] != null
        ? ResponsibleEmployee.fromJson(json['name'])
        : null;
  }


  String get differenceInDays{
    String difference = '';
    var startDayARR = (holidayStart ?? '').split('-');
    var endDayARR = (holidayEnd ?? '').split('-');

    final startDay = DateTime(int.parse(startDayARR[0]),int.parse(startDayARR[1]),int.parse(startDayARR[2]));
    final endDay = DateTime(int.parse(endDayARR[0]),int.parse(endDayARR[1]),int.parse(endDayARR[2]));


    final days = (endDay.difference(startDay).inDays + 1);
    difference =  days == 1 ? 'day'.tr : days == 2 ? '2_days'.tr : days > 10 ? days.toString() + ' ' + 'day'.tr : (days.toString() + ' ' + 'days'.tr);
    return difference;
  }

  // OrderType? get myOrderType => _holidayType;

  @override
  String get file => _file ?? '';

  @override
  String get orderName => 'HolidaysData';

  String get holidayType => '${type?.name}';

  @override
  String get orderDate {
    return (createdAt ?? '').split('T')[0];
  }

  @override
  String get orderStatus => status == null  ? 'not_confirmed' : '${status?.statusAr}';

  @override
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');

  @override
  int get statusID => status == null  ? 1 : status?.id ?? 1;

  @override
  int get orderID =>  id ?? -1;

  @override
  String? pdfUrl;
}

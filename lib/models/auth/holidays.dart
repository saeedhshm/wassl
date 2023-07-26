import '../../helpers/constants/print_ln.dart';

class Holidays {
  bool? success;
  HolidayBalance? data;
  String? message;

  Holidays({this.success, this.data, this.message});

  Holidays.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? HolidayBalance.fromJson(json['data']) : null;
    message = json['message'];
  }


}

class HolidayBalance {
  int? id;
  int? employeeId;
  dynamic openingVacationsCount;
  dynamic usedVacationsCount;
  dynamic availableVacationsCount;
  dynamic discountVacationsCount;
  dynamic sickVacationsCount;
  dynamic unpaidVacationsCount;
  dynamic createdAt;
  dynamic updatedAt;

  HolidayBalance(
      {this.id,
        this.employeeId,
        this.openingVacationsCount,
        this.usedVacationsCount,
        this.availableVacationsCount,
        this.discountVacationsCount,
        this.sickVacationsCount,
        this.unpaidVacationsCount,
        this.createdAt,
        this.updatedAt});

  HolidayBalance.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    employeeId = json['employee_id'];
    openingVacationsCount = json['opening_vacations_count'];
    usedVacationsCount = json['used_vacations_count'];
    availableVacationsCount = json['available_vacations_count'];
    discountVacationsCount = json['discount_vacations_count'];
    sickVacationsCount = json['sick_vacations_count'];
    unpaidVacationsCount = json['unpaid_vacations_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

import 'package:get/get.dart';

class Finance {
  Employee? employee;
  List<Allowance> allowances = <Allowance>[];
  dynamic totalAllowanceAmount;
  dynamic salaryAfter;

  Finance(
      {this.employee,
        this.totalAllowanceAmount,
        this.salaryAfter});

  Finance.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    if (json['allowances'] != null) {
     
      json['allowances'].forEach((v) {
        allowances.add(Allowance.fromJson(v));
      });
    }
    totalAllowanceAmount = json['totalAllownceAmount'];
    salaryAfter = json['salaryAfter'];
  }


}

class Employee {
  int? id;
  String? code;
  String? salary;
  String? _fullName;
  String? _fullNameEn;

  Employee({this.id, this.code, this.salary,});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    salary = json['salary'];
    _fullName = json['full_name'];
    _fullNameEn = json['full_name_en'];
  }

  String get fullName{
    return ('lang_code'.tr == 'ar' ? _fullName : _fullNameEn) ?? '';
  }

}
class Allowance {
  int? id;
  String? amount;
  int? allowancesTypeId;
  AllowanceType? allowanceType;

  Allowance(
      {this.id, this.amount, this.allowancesTypeId, this.allowanceType});

  Allowance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    allowancesTypeId = json['allowances_type_id'];
    allowanceType = json['allowances_type'] != null
        ? AllowanceType.fromJson(json['allowances_type'])
        : null;
  }


}

class AllowanceType {
  int? id;
  String? _nameAr;
  String? _nameEn;
  String? createdAt;
  String? updatedAt;

  AllowanceType(
      {this.id, this.createdAt, this.updatedAt});

  AllowanceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    _nameAr = json['name_ar'];
    _nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String get name{
    return ('lang_code'.tr == 'ar' ?  _nameAr : _nameEn) ?? '';
  }


}
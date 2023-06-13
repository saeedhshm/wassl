import 'package:get/get.dart';

class Salaries {
  Employee? employee;
  List<SalaryOfMonth> salaries = <SalaryOfMonth>[];

  Salaries({this.employee, });

  Salaries.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    if (json['months_salary'] != null) {

      json['months_salary'].forEach((v) {
        salaries.add(SalaryOfMonth.fromJson(v));
      });
    }
  }

}

class Employee {
  int? id;
  String? code;
  String? salary;
  String? _nameAr;
  String? _nameEn;

  Employee({this.id, this.code, this.salary,});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    salary = json['salary'];
    _nameAr = json['full_name'];
    _nameEn = json['full_name_en'];
  }


  String get name{
    return (Get.locale?.languageCode ?? '') == 'ar' ?  _nameAr ?? '' : _nameEn ?? '';
  }
}

class SalaryOfMonth {
  List<Discounts>discounts = <Discounts>[];
  List<Allowances>allowances = <Allowances>[];
  dynamic totalDiscountAmount;
  dynamic totalAllownceAmount;
  String? _month;
  dynamic salaryAfter;



  SalaryOfMonth();

  SalaryOfMonth.fromJson(Map<String, dynamic> json) {
    if (json['allowances'] != null) {

      json['allowances'].forEach((v) {
        allowances.add(new Allowances.fromJson(v));
      });
    }
    if (json['discounts'] != null) {

      json['discounts'].forEach((v) {
        discounts.add(Discounts.fromJson(v));
      });
    }
    totalDiscountAmount = json['totalDiscountAmount'];
    totalAllownceAmount = json['totalAllownceAmount'];
    _month = json['month'];
    salaryAfter = json['salaryAfter'];
  }

  String get month{
    var m = _month?.split('-').last ?? '';

    return m;
  }

  String get year{
    var y = _month?.split('-').first ?? '';;

    return y;
  }

}

class Discounts {
  int? id;
  String? amount;
  int? employeeSalariesDiscountsTypeId;
  AllowancesType? employeeSalaryDiscountType;

  Discounts(
      {this.id,
        this.amount,
        this.employeeSalariesDiscountsTypeId,
        this.employeeSalaryDiscountType});

  Discounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    employeeSalariesDiscountsTypeId =
    json['employee_salaries_discounts_type_id'];
    employeeSalaryDiscountType = json['employee_salary_discount_type'] != null
        ? new AllowancesType.fromJson(json['employee_salary_discount_type'])
        : null;
  }

}


class Allowances {
  int? id;
  int? employeeId;
  int? allowancesTypeId;
  String? amount;
  String? createdAt;
  String? updatedAt;
  AllowancesType? allowancesType;

  Allowances(
      {this.id,
        this.employeeId,
        this.allowancesTypeId,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.allowancesType});

  Allowances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    allowancesTypeId = json['allowances_type_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    allowancesType = json['allowances_type'] != null
        ? new AllowancesType.fromJson(json['allowances_type'])
        : null;
  }

}

class AllowancesType {
  int? id;
  String? _nameAr;
  String? _nameEn;
  String? createdAt;
  String? updatedAt;

  AllowancesType(
      {this.id, this.createdAt, this.updatedAt});

  AllowancesType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    _nameAr = json['name_ar'];
    _nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String get name{
    return (Get.locale?.languageCode ?? '') == 'ar' ?  _nameAr ?? '' : _nameEn ?? '';
  }

}

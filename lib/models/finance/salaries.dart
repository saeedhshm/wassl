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
  List<Discounts>? discounts;
  dynamic totalDiscountAmount;
  dynamic totalAllownceAmount;
  String? _month;
  dynamic salaryAfter;



  SalaryOfMonth();

  SalaryOfMonth.fromJson(Map<String, dynamic> json) {
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(Discounts.fromJson(v));
      });
    }
    totalDiscountAmount = json['totalDiscountAmount'];
    totalAllownceAmount = json['totalAllownceAmount'];
    _month = json['month'];
    salaryAfter = json['salaryAfter'];
  }

  String get month{
    var m = _month?.split('-').first ?? '';

    return m;
  }

  String get year{
    var y = _month?.split('-').last ?? '';;

    return y;
  }

}

class Discounts {
  int? id;
  String? amount;
  int? employeeSalariesDiscountsTypeId;
 dynamic employeeSalaryDiscountType;

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
    employeeSalaryDiscountType = json['employee_salary_discount_type'];
  }

}

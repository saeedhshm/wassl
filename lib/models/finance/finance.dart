class Finance {
  Employee? employee;
  List<dynamic>? allowances;
  int? totalAllowanceAmount;
  int? salaryAfter;

  Finance(
      {this.employee,
        this.allowances,
        this.totalAllowanceAmount,
        this.salaryAfter});

  Finance.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    // if (json['allowances'] != null) {
    //   allowances = <Null>[];
    //   json['allowances'].forEach((v) {
    //     allowances!.add(new Null.fromJson(v));
    //   });
    // }
    totalAllowanceAmount = json['totalAllownceAmount'];
    salaryAfter = json['salaryAfter'];
  }


}

class Employee {
  int? id;
  String? code;
  String? salary;
  String? fullName;
  String? fullNameEn;

  Employee({this.id, this.code, this.salary, this.fullName, this.fullNameEn});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    salary = json['salary'];
    fullName = json['full_name'];
    fullNameEn = json['full_name_en'];
  }

}

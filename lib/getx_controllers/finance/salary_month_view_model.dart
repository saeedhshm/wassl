import 'package:get/get.dart';

import '../../models/finance/salaries.dart';

class SalaryOfMonthViewModel{

  SalaryOfMonth salary;

  SalaryOfMonthViewModel(this.salary);

  String get salaryMonth{
    return salary.month.tr;
}

String get salaryYear{
    return salary.year.tr;
}

String get salaryAfter{
  return '${salary.salaryAfter} '+'SR'.tr;
}
}
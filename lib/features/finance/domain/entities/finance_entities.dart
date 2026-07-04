class SalaryEntity {
  final int? id;
  final String? month;
  final String? salary;
  final String? totalAllowanceAmount;
  final String? totalDiscountAmount;
  final String? salaryAfter;

  const SalaryEntity({
    this.id,
    this.month,
    this.salary,
    this.totalAllowanceAmount,
    this.totalDiscountAmount,
    this.salaryAfter,
  });
}

class FinanceEntity {
  final String? baseSalary;
  final List<SalaryEntity>? salaries;

  const FinanceEntity({this.baseSalary, this.salaries});
}

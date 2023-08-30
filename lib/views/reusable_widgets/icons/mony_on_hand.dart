import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class SalaryMoneyOnHandIcon extends StatelessWidget {

  final Color color;
  const SalaryMoneyOnHandIcon({this.color = AppColors.mainOrangeColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/prosedures/salaries.png',color: color,);
  }
}

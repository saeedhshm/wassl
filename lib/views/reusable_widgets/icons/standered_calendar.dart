import 'package:flutter/material.dart';

import '../../../helpers/constants/app_colors.dart';

class StandardCalendarIcon extends StatelessWidget {

  final Color? color;
  const StandardCalendarIcon({super.key,this.color = AppColors.iconsColor});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/order_details/calendar.png',color: color,);
  }
}

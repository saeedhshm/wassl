import 'package:flutter/material.dart';

import '../../../helpers/constants/app_colors.dart';
import '../svg_widget.dart';

class DollarOnHandIcon extends StatelessWidget {

  final Color? color;
  const DollarOnHandIcon({super.key,this.color = AppColors.iconsColor});

  @override
  Widget build(BuildContext context) {
    return  SvgWidget('assets/images/loan_type.svg',color: color,);
  }
}

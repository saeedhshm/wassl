import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../svg_widget.dart';

class MoneyOnHandIcon extends StatelessWidget {

  final Color color;
  const MoneyOnHandIcon({this.color = AppColors.iconsColor,super.key});

  @override
  Widget build(BuildContext context) {
    return  SvgWidget('assets/images/money_on_hand.svg',color: color,);
  }
}

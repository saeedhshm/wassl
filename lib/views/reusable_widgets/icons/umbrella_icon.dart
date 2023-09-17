import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../svg_widget.dart';

class UmbrellaIcon extends StatelessWidget {

  final Color color;
  const UmbrellaIcon({this.color = AppColors.iconsColor,super.key});

  @override
  Widget build(BuildContext context) {
    return  SvgWidget('assets/images/holidays.svg',color: color,);
  }
}

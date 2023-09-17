import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../svg_widget.dart';

class PersonInLockIcon extends StatelessWidget {

  final Color color;
  const PersonInLockIcon({this.color = AppColors.iconsColor,super.key});

  @override
  Widget build(BuildContext context) {
    return  SvgWidget('assets/images/custody.svg',color: color,);
  }
}

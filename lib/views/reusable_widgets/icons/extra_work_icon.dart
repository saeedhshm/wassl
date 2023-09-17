


import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../svg_widget.dart';

class ExtraWorkIcon extends StatelessWidget {

  final Color? color;
  const ExtraWorkIcon({super.key,this.color = AppColors.iconsColor});

@override
Widget build(BuildContext context) {
return  SvgWidget('assets/images/extra_work.svg',color: color,);
}
}

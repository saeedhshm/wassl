import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../svg_widget.dart';

class LetterIcon extends StatelessWidget {

  final Color color;
  const LetterIcon({this.color = AppColors.iconsColor,super.key});

  @override
  Widget build(BuildContext context) {
    return  SvgWidget('assets/images/letter.svg',color: color,);
  }
}

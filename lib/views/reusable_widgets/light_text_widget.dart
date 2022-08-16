import 'package:flutter/material.dart';

import '../../helpers/constants/app_colors.dart';
import 'localized_text.dart';

class LightTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  const LightTextWidget(this.text,{Key? key,this.fontSize = 15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalizedText(text,textStyle: TextStyle(
        color: AppColors.lightGreyTextColor,
        fontWeight: FontWeight.w500,
        fontSize: fontSize
    ),);
  }
}

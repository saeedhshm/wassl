import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import 'localized_text.dart';

class DarkTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
   DarkTextWidget(this.text, {Key? key,this.fontSize = 15,this.fontWeight = FontWeight.w500}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalizedText(text,textStyle: TextStyle(
      color: AppColors.darkGreyTextColor,
      fontWeight: fontWeight,
      fontSize: fontSize
    ),);
  }
}

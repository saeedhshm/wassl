import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import 'localized_text.dart';

class MainTitleText extends StatelessWidget {

  final String text;
   MainTitleText(this.text,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalizedText(text,textStyle: TextStyle(
      color: AppColors.mainDeepGreyColor,
      fontSize: 16,
      fontWeight: FontWeight.bold
    ),);
  }
}

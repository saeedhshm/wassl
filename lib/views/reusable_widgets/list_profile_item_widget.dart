import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/dark_text_widget.dart';

import 'load_image.dart';

class ListProfileItemWidget extends StatelessWidget {

  final String icon;
  final String title;
  final double spaceInBetween;
  final double fontSize;
  final FontWeight fontWeight;
  final double iconSize;
   const ListProfileItemWidget({Key? key,this.iconSize = 30,required this.title,required this.icon,this.spaceInBetween = 8,this.fontSize = 15,this.fontWeight = FontWeight.w500}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightBackgroundColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                Image.asset(icon,width: iconSize,color: AppColors.darkGreyTextColor,),
                SizedBox(width: spaceInBetween,),
                DarkTextWidget(title,fontSize: fontSize,fontWeight: fontWeight,),
                Spacer(),
                Image.asset('assets/images/list_arrow_item_${'lang_code'.tr}.png',width: 35,)

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.borderTextFieldColor,
            ),
          )
        ],
      ),
    );
  }
}

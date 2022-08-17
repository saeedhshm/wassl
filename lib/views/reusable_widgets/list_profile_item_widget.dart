import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/dark_text_widget.dart';

class ListProfileItemWidget extends StatelessWidget {

  final String icon;
  final String title;
   ListProfileItemWidget({Key? key,required this.title,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightBackgroundColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(icon,width: 35,color: AppColors.darkGreyTextColor,),
                SizedBox(width: 5,),
                DarkTextWidget(title,fontSize: 20,),
                Spacer(),
                Image.asset('assets/images/list_arrow_item.png',width: 35,)

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

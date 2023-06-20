import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class HolidayInfoItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String count;
  const HolidayInfoItemWidget({
    Key? key,
    required this.count,
    required this.title,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2.5,
      height: Get.width / 2.2,
      margin: EdgeInsets.only(right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(icon,width: 45,),
            Spacer(),
            Text(title,style: TextStyle(
              color: AppColors.darkGreyTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 16,),
            Text(count,style: TextStyle(
                color: AppColors.borderTextFieldColor,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
    );
  }
}
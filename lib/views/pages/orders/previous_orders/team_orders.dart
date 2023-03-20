import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class TeamOrderPage extends StatelessWidget {
  const TeamOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: AppColors.mainBackgroundColor,
      child: Center(
        child: Text('No Team Orders Yet'.tr,style: TextStyle(
          color: AppColors.darkGreyTextColor,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class HolidaysWidget extends StatelessWidget {

  final HomeController homeController = Get.find();

   HolidaysWidget({
    Key? key,
  }) : super(key: key){
     homeController.getHolidaysData();
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('yearly_vacations_balance'.tr,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),),
            Obx(() => homeController.gettingHolidays.value ? SendingLoadingWidget() : Row(
              children: [
                 Text('${homeController.holidaysBalance.value.data?.availableVacationsCount}',style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
                const Text(' / ',style: TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
                 Text('${homeController.holidaysBalance.value.data?.openingVacationsCount}',style: const TextStyle(
                    color: AppColors.lightGreyTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
                const Spacer(),
                Text('day'.tr),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
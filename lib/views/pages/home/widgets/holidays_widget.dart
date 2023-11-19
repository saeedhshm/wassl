import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class HolidaysWidget extends StatelessWidget {

  final HomeController homeController = Get.find();

   HolidaysWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(20.0),
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
                color: AppColors.iconsColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),),
            Obx(() => homeController.appController.gettingHolidays.value ? const SendingLoadingWidget() : Row(
              children: [
                 Text('${homeController.appController.holidaysBalance.value.data?.availableVacationsCount ?? 0}',style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
                const Text(' / ',style: TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
                 Text('${homeController.appController.holidaysBalance.value.data?.openingVacationsCount}',style:  TextStyle(
                    color: AppColors.borderTextFieldColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
                const Spacer(),
                Text('day'.tr,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                ),),
              ],
            ))
          ],
        ),
      ),
    );
  }
}